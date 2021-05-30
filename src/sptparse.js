// XXX keywords are case insensitive
// are Ids case insensitive too??

// result parsing Darkstone released scripts:
//Error: [../files/data/script/fc3_shadire.spt:10088] Unexpected token TIMER in STATE.MULTI definition
//Error: [../files/data/script/questfinal.spt:23490] Unexpected token { in STATE definition
//Error: [../files/data/script/dp2_quest3.spt:25390] Expected '}', found '�'
//Error: [../files/data/script/entree.spt:14285] Unexpected token TEXT in STATE.ACTION definition
//Error: [../files/data/script/fc3_horgan.spt:6669] Unexpected token TRAP in TRAP definition
//Error: [../files/data/script/fc3_xspider.spt:37972] Expected '}', found 'content'

const { captureRejectionSymbol } = require('events');
const fs = require('fs');

const spt = fs.readFileSync(process.argv[2], 'utf8');

let off = 0;

const skipWhitespace = () => {
    // Skip all whitespace
    while(off < spt.length && '\t\r\n '.includes(spt[off])) {
        ++off;
    }

    // Check for comment start
    if (off +2 <spt.length && spt[off] === '/' && spt[off+1] === '*') {
        off += 2;

        // Skip comment, no nesting allowed
        while(off < spt.length) {
            if (off +2 < spt.length && spt[off] === '*' && spt[off+1] === '/') {
                off += 2;
                break;
            }
            ++off;
        }

        // Skip any whitespace after comment
        if (off < spt.length) {
            skipWhitespace();
        }
    }
}

const getNextToken = () => {
    skipWhitespace();

    if (off >= spt.length)
        return undefined;

    switch(spt[off]) {
        // Handle delimiters
        case '{':
        case '}':
        case '|':
        case ',':
            return spt[off++];
        default: 
            // Detect numbers (mostly for language indices)
            let s = '';
            while (/^[0-9\-]$/i.test(spt[off])) {
                s += spt[off++];
            }
            if (s.length) {
                return parseInt(s, 10);
            }
            // Detect identifiers (alnum)
            // Note: we can include numbers here as anything
            // that started with a digit would have been picked up
            // by the number code above
            while(/^[a-z0-9_\.]$/i.test(spt[off])) { // XXX period is in there for filenames
                s += spt[off++];
            }
            if (s.length)
                return s;

            return spt[off++];
    }
}

const failParser = msg => {
    throw new Error(`[${process.argv[2]}:${off}] ${msg}`);
}

const expectToken = tok => {
    const nextTok = getNextToken();
    if (nextTok != tok) {
        failParser(`Expected '${tok}', found '${nextTok}'`)
    }
}

const parseLiteral = () => {
    expectToken('{');
    let lit = getNextToken();
    expectToken('}');

    return lit;
}

const parseLiteralString = () => {
    expectToken('{');
    let s = '';
    while(off < spt.length && spt[off] !== '}') {
        s += spt[off++];
    }
    expectToken('}');
    return s;
}

const parseMLString = () => {
    let str = {};

    expectToken('{');
    let tok;
    while((tok = getNextToken()) !== '}' && tok !== undefined) {
        if (typeof tok !== 'number') {
            failParser(`Expected language number, found '${tok}'`)
        }
        let s = parseLiteralString();
        str[tok] = s;
    }

    return str;
}

const parseFlags = () => {
    expectToken('{');

    let flags = [];
    let tok;

    do {
        tok = getNextToken();
        flags.push(tok);
    } while((tok=getNextToken()) === '|');
    if (tok !== '}') {
        failParser(`Missing } in flags list`);
    }

    return flags;
}

const parseObject = context => {
    let object = {};
    let tok;
    
    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'CONTAINER':
                object.container = parseLiteral();
                break;
            case 'KEY':
                object.key = parseLiteral();
                break;
            case 'PARENT':
                object.parent = parseLiteral();
                break;
            case 'FLAG':
                object.flags = parseFlags();
                break;
            case 'NAME':
                object.name = parseMLString();
                break;
            case 'NAME2':
                object.name2 = parseMLString();
                break;
            case 'MAGIC':
                object.parent = parseLiteral();
                break;
            default:
                failParser(`Unexpected token ${tok} in OBJECT definition`)
        }
    }

    context.objects.push(object);
}

const parseDamage = () => {
    expectToken('{');
    let damage = [ getNextToken() ];
    expectToken(',');
    damage.push( getNextToken() );
    expectToken('}');

    return damage;
}

const parseRoom = context => {
    let room = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'FLAG':
                room.flags = parseFlags();
                break;
            case 'DAMAGE':
                room.damage = parseDamage();
                break;
            case 'KEY':
                room.key = parseLiteral();
                break;
            case 'NAME':
                room.name = parseMLString();
                break;
            case 'LEVEL':
                room.level = parseLiteral();
                break;
            case 'LIFE':
                room.life = parseLiteral();
                break;
            case 'LOCATION':
                room.level = parseLiteral();
                break;    
            default:
                failParser(`Unexpected token ${tok} in ROOM definition`)    
        }
    }

    context.rooms.push(room);
}

const parseAgent = context => {
    let agent = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'KEY':
                agent.key = parseLiteral();
                break;
            case 'FLAG':
                agent.flag = parseFlags();
                break;
            case 'LIVE':
            case 'LIFE':
                agent.life = parseLiteral();
                break;    
            case 'BOOST':
                agent.boost = parseLiteral();
                break;
            case 'DAMAGE':
                agent.damage = parseDamage();
                break;    
            case 'GIVE':
                agent.give = parseLiteral();
                break;
            case 'PATH':
                agent.path = parseLiteral();
                break;
            case 'TRACK':
                agent.track = parseLiteral();
                break;
            case 'ROOM':
                agent.room = parseLiteral();
                break;
            case 'ANIM':
                agent.anim = parseLiteral();
                break;
            case 'NAME':
                agent.name = parseMLString();
                break;
            case 'TXT0':
                agent.txt0 = parseMLString();
                break;
            case 'TXT1':
                agent.txt1 = parseMLString();
                break;
            case 'TXT2':
                agent.txt2 = parseMLString();
                break;
            case 'TXT3':
                agent.txt3 = parseMLString();
                break;        

            default:
                failParser(`Unexpected token ${tok} in AGENT definition`)    
        }
    }

    context.agents.push(agent);
}

const parseQuest = context => {
    let quest = {
        objects: [],
        rooms: [],
        agents: [],
    };
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'KEY':
                quest.key = parseLiteral();
                break;
            case 'QUESTINTRO':
                quest.intro = parseMLString();
                break;
            case 'ENTRANCE':
                quest.entrance = parseLiteral();
                break;
            case 'LAND':
                quest.land = parseLiteral();
                // ASSERT number?
                break;
            case 'LINK':
                expectToken('{');
                quest.link = [ getNextToken() ];
                expectToken(',');
                quest.link.push( getNextToken() );
                expectToken('}');
                break;
            case 'QUESTNAME':
                quest.name = parseMLString();
                break;

            case 'AGENT':
                parseAgent(quest);
                break;
            case 'OBJECT':
                parseObject(quest);
                break;
            case 'ROOM':
                parseRoom(quest);
                break;

            default:
                failParser(`Unexpected token ${tok} in QUEST definition`)
        }
    }

    context.quests.push(quest);
}

const parseCondition = () => {
    let cond = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok.toUpperCase()) {
            case 'OBJECT':
                cond.object = parseLiteral();
                break;
            case 'OBJECTWEAR':
                cond.objectWear = parseLiteral();
                break;
            case 'OBJECTINVENT':
                cond.objectInvent = parseLiteral();
                break;
            case 'OBJECTHAND':
                cond.objectHand = parseLiteral();
                break;
            case 'CHANGELEVEL':
                cond.changeLevel = parseLiteral();
                break;
            case 'CLICK':
                expectToken('{');
                expectToken('}');
                cond.click = null;
                break;
            case 'CLOSEPANEL':
                expectToken('{');
                expectToken('}');
                cond.closePanel = true;
                break;
            case 'COLLID':
                cond.collId = parseLiteral();
                break;
            case 'COLLIDEX':
                expectToken('{');
                cond.collIdex = [ getNextToken() ];
                expectToken(',');
                cond.collIdex.push(getNextToken());
                expectToken(',');
                cond.collIdex.push(getNextToken());
                expectToken('}');
                break;
            case 'GOTO':
                cond.goto = parseLiteral();
                break;
            case 'MONSTERCOUNT':
                expectToken('{');
                cond.monsterCount = [ getNextToken() ];
                expectToken(',');
                cond.monsterCount.push(getNextToken());
                expectToken('}');
                break;
            case 'MSG':
                cond.msg = parseLiteral();
                break;
            case 'PROJECTILEHIT':
                expectToken('{');
                expectToken('}');
                cond.projectileHit = true;
                break;
            case 'SENSEWEAR':
                expectToken('{');
                cond.senseWear = [ getNextToken() ];
                expectToken(',');
                cond.senseWear.push(getNextToken());
                expectToken('}');
                break;
            case 'SENSEOBJMAGIC':
                cond.senseObjMagic = parseLiteral();
                break;
            case 'TIMER':
                cond.timer = parseLiteral();
                break;
            case 'ENDANIM':
                cond.endAnim = null;
                expectToken('{');
                tok = getNextToken();
                if (tok !== '}') {
                    cond.endAnim = tok;
                    expectToken('}');
                }
                break;
            case 'VEQ':
                expectToken('{');
                cond.vEq = [ getNextToken() ];
                expectToken(',');
                cond.vEq.push(getNextToken());
                expectToken('}');
                break;
            case 'VNE':
                expectToken('{');
                cond.vNe = [ getNextToken() ];
                expectToken(',');
                cond.vNe.push(getNextToken());
                expectToken('}');
                break;
            case 'VGE':
                expectToken('{');
                cond.vGe = [ getNextToken() ];
                expectToken(',');
                cond.vGe.push(getNextToken());
                expectToken('}');
                break;
            case 'VLT':
                expectToken('{');
                cond.vLt = [ getNextToken() ];
                expectToken(',');
                cond.vLt.push(getNextToken());
                expectToken('}');
                break;
            default:
                failParser(`Unexpected token ${tok} in STATE.MULTI.CONDITION definition`)
        }
    }

    return cond;
}

const parseMulti = () => {
    let multi = [];
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok.toUpperCase()) {
            case 'CONDITION':
                multi.push(parseCondition());
                break;

            default:
                failParser(`Unexpected token ${tok} in STATE.MULTI definition`)
        }
    }

    return multi;
}

const parseProjectile = () => {
    let proj = {};

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'KEY':
                proj.key = parseLiteral();
                break;
            case 'DAMAGEMIN':
                proj.damageMin = parseLiteral();
                break;
            case 'DAMAGEMAX':
                proj.damageMax = parseLiteral();
                break;
            case 'SPEED':
                proj.speed = parseLiteral();
                break;
            case 'ROTATION':
                proj.rotation = parseLiteral();
                break;
            case 'YOFFSET':
                proj.yOffset = parseLiteral();
                break;
            default:
                failParser(`Unexpected token ${tok} in STATE.ACTION.PROJECTILE definition`)
        }
    }

    return proj;
}

const parseAction = () => {
    let action = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok.toUpperCase()) {
            case 'OBJECT':
                action.object = parseLiteral();
                break;
            case 'EFFECT':
                action.effect = parseLiteral();
                break;
            case 'FREEZE':
                expectToken('{');
                action.freeze = [ getNextToken() ];
                expectToken(',');
                action.freeze.push( getNextToken() );
                expectToken('}');
                break;
            case 'OBJECTMOUSE':
                action.objectMouse = parseLiteral();
                break;
            case 'PLAYSONG':
                action.playSong = parseLiteral();
                break;
            case 'SETLOADING':
                action.setLoading = parseLiteral();
                break;
            case 'SOUND':
                action.sound = parseLiteral();
                break;
            case 'CAMERAFROM':
                expectToken('{');
                action.cameraFrom = [ getNextToken() ];
                expectToken(',');
                action.cameraFrom.push( getNextToken() );
                expectToken('}');
                break;
            case 'CAMERATO':
                expectToken('{');
                action.cameraTo = [ getNextToken() ];
                expectToken(',');
                action.cameraTo.push( getNextToken() );
                expectToken('}');
                break;
            case 'CAMERATIME':
                expectToken('{');
                action.cameraTime = [ getNextToken() ];
                tok = getNextToken();
                if (tok === ',') {
                    action.cameraTime.push( getNextToken() );
                    expectToken('}');
                } else if (tok !== '}') {
                    failParser(`Invalid CAMERATIME definition`)
                }
                break;
            case 'CHARGECRISTAL':
                expectToken('{');
                expectToken('}');
                break;
            case 'HIT':
                action.hit = parseLiteral();
                break;
            case 'FMV':
                action.fmv = parseLiteral();
                break;
            case 'HITEX':
                expectToken('{');
                action.hitEx = [ getNextToken() ];
                expectToken(',');
                action.hitEx.push( getNextToken() );
                expectToken('}');
                break;
            case 'MONSTER':
                action.monster = parseLiteral();
                break;
            case 'PROJECTILE':
                action.projectile = parseProjectile();
                break;
            case 'RANDPANEL':
                action.randPanel = parseLiteral();
                break;
            case 'REMOVEOBJECT':
                action.removeObject = parseLiteral();
                break;
            case 'MSG':
                action.msg = parseLiteral();
                break;
            case 'TELEPORT2ND':
                action.teleport2nd = parseLiteral();
                break;
            case 'VSET':
                expectToken('{');
                action.vSet = [ getNextToken() ];
                expectToken(',');
                action.vSet.push( getNextToken() );
                expectToken('}');
                break;
            case 'VADD':
                expectToken('{');
                action.vAdd = [ getNextToken() ];
                expectToken(',');
                action.vAdd.push( getNextToken() );
                expectToken('}');
                break;
            default:
                failParser(`Unexpected token ${tok} in STATE.ACTION definition`)
        }
    }

    return action;
}

const parseState = context => {
    let state = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok.toUpperCase()) {
            case 'KEY':
                state.key = parseLiteral();
                break;
            case 'FLAG':
                state.flags = parseFlags();
                break;
            case 'CHANGELEVEL':
                state.changeLevel = parseLiteral();
                break;
            case 'CONDITION':
                state.condition = parseLiteral();
                break;
            case 'TEXT':
                state.text = parseMLString();
                break;
            case 'GOTO':
                state.goto = parseLiteral();
                break;
            case 'SETLOWCOLLID':
                state.lowCollid = parseLiteral();
                break;
            case 'SETCOLLID':
                state.setCollid = parseLiteral();
                break;
            case 'CLEARCOLLID':
                state.clearCollid = parseLiteral();
                break;
            case 'SKELFILE':
                state.skelFile = parseLiteral();
                break;
            case 'SKELNAME':
                state.skelName = parseLiteral();
                break;
            case 'SKELANIM':
                state.skelAnim = parseLiteral();
                break;k
            case 'FRAME':
                state.frame = parseLiteral();
                break;
            case 'JUMP':
                state.jump = parseLiteral();
                break;
            case 'FAIL':
                state.fail = parseMLString();
                break;
            case 'FAILPANEL':
                state.failPanel = parseMLString();
                break;
            case 'TEXTPANEL':
                state.textPanel = parseMLString();
                break;
            case 'OBJECT':
                state.object = parseLiteral();
                break;
            case 'MULTI':
                state.multi = parseMulti();
                break;
            case 'ACTION':
                state.action = parseAction();
                break;
            case 'MSG':
                state.msg = parseLiteral();
                break;
            default:
                failParser(`Unexpected token ${tok} in STATE definition`)
            }
    }

    context.states.push(state);
}

const parseTrap = context => {
    let trap = {
        states: [],
    };
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok.toUpperCase()) {
            case 'KEY':
                trap.key = parseLiteral();
                break;
            case 'FLAG':
                trap.flags = parseFlags();
                break;
            case 'NAME':
                trap.name = parseMLString();
                break;
            case 'SKELFILE':
                trap.skelfile = parseLiteral();
                break;
            case 'STATE':
                parseState(trap);
                break;
            default:
                failParser(`Unexpected token ${tok} in TRAP definition`)
        }
    }

    context.traps.push(trap);
}

const parseNode = context => {
    let node = {};
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'KEY':
                node.key = parseLiteral();
                break;
            case 'ANIM':
                node.anim = parseLiteral();
                break;
            case 'SKEL':
                node.skel = parseLiteral();
                break;    
            case 'WAIT':
                node.wait = parseLiteral();
                break;
            default:
                failParser(`Unexpected token ${tok} in NODE definition`)
        }
    }

    context.nodes.push(node);
}

const parsePath = context => {
    let path = {
        nodes: [],
    };
    let tok;

    expectToken('{');

    while((tok=getNextToken()) !== '}') {
        switch(tok) {
            case 'KEY':
                path.key = parseLiteral();
                break;
            case 'FLAG':
                path.flags = parseFlags();
                break;

            case 'NODE':
                parseNode(path);
                break;

            default:
                failParser(`Unexpected token ${tok} in PATH definition`)
        }
    }

    context.paths.push(path);
}

const parseSPT = () => {
    const obj = {
        quests: [],
        traps: [],
        paths: [],
    };
    let tok;

    while((tok=getNextToken()) !== undefined) {
        switch(tok) {
            case 'QUEST':
                parseQuest(obj);
                break;
            case 'TRAP':
                parseTrap(obj);
                break;
            case 'PATH':
                parsePath(obj);
                break;
            default:
                failParser(`Unexpected top-level token '${tok}'`)
        }
    }

    return obj;
}

console.log( process.argv[2] );
console.log( parseSPT() );
