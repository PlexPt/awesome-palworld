# 幻兽帕鲁你所需要了解的一切

![pal](pic/pal.png)

《幻兽帕鲁》是由日本开发商Pocket Pair推出的一款动作冒险生存游戏。自 2024年 1 月 19 日发售以来，仅仅 3 天时间就登上 Steam 史上同时在线玩家数量第2名，超越了《CS2》来到历史第二位，仅次于《PUBG》，堪称史无前例的现象级爆款作品。

发售五天销量突破700万份、最高 200万+ 同时在线。[实时数据](https://steamdb.info/app/1623730/charts/)

游戏设定在一个居住着类似动物的生物“帕鲁”的开放世界中，玩家可以战斗并捕捉帕鲁，然后用它们来建造基地、骑乘和战斗。

《幻兽帕鲁》可单人游玩，也可通过多人服务器来让多名玩家同时在线游戏，理论支持没有上限，但是实际上百人很困难。

## 帕鲁守则

1. 帕鲁大陆最不缺的就是帕鲁，你不干有的是帕鲁干。
2. 哪怕你是高达三级的专业技术帕鲁，但你有红色陋习词条，你就不如旁边一级技术的帕鲁。
3. 帕鲁的成本取决与花费了几个帕鲁球，而一个普通帕鲁球的成本是一个帕鲁矿+3个木头+3个石头，如果一个帕鲁工作生产出的物资不能达到他的成本的几倍，那就加大工作强度。
4. 让一个帕鲁全天候高强度工作，累倒后卖掉换新的帕鲁，会有更高的效益。
5. 与其花费大量材料成本买药给帕鲁治病，不如把他卖掉，换成新的帕鲁，会有更高的效益。
6. 不想跑太远去卖帕鲁的话，可以把病倒的不干活的帕鲁肢解掉，切出来的肉还可以喂给新来干活的帕鲁。
7. 帕鲁配种不需要考虑种族、等级、属性，我们只需要不停的配种来孵蛋，只要能孵化出一个极品帕鲁就赚了。
8. 帕鲁并不需要很好的居住环境和进食，所以只要随地放个草垛子，喂点浆果就可以了，如果有帕鲁闹情绪，那是他不识好歹，卖了它。
9. 帕鲁生来就是为我们训练家工作的，不能为训练家效力的帕鲁没有存在的价值，让他们自己刷新掉吧。
10. 野生的、群居的帕鲁，或者别人家养的强大帕鲁我们训练家打不过，但是我们有控制帕鲁的帕鲁球、被我们抓来为我们卖命的帕鲁，以及和其他训练家交易的物资，这些帕鲁翻不了天。
11. 帕鲁能吃苦，那就吃更多的苦，既然他们可以承受高强度工作安排还能保持SAN值，那一定可以承受更高强度的工作。
12. 只有让部分属性高的帕鲁强大起来，才能再带领其他帕鲁一起强大。
13. 帕鲁保护团体既然可以被帕鲁球捕获，那么他们就不是人。
14. 既然工作过劳的帕鲁扔进火里烧死，然后去终端免费治疗之后就能恢复工作态度，那么我们就应该放弃那些昂贵的治疗药物，为所有的帕鲁提供免费的过劳死治疗。
15. 优秀种族的帕鲁都是会被训练家拿去配种的，这些种族不一定强大，甚至即便这些帕鲁没有一身的好词条，但一定可以通过配种与某些强大的种族产生关系，如果一个帕鲁没有被配种，那一定是他的种族有问题。

## Palworld 数据库

https://palworld.gg/zh-Hans

## 开服

目前分为官服和专用服务器。官服很卡国内体验很差。

如果是自己开服则基本不需要加速器。

服务器配置官方推荐是8G内存起步，16G比较推荐。

#### 官方文档

[Palworld tech guide - Dedicated server guide (palworldgame.com)](https://tech.palworldgame.com/dedicated-server-guide)

### Linux

https://github.com/miaowmint/palworld

#### Docker（推荐）

https://github.com/thijsvanloef/palworld-server-docker

需要修改下面的/pal为目标路径，修改ADMIN_PASSWORD管理员密码

```
docker run -d \
    --name pal \
    -p 8211:8211/udp \
    -p 27015:27015/udp \
    -v /pal:/palworld/ \
    -e PUID=1000 \
    -e PGID=1000 \
    -e PORT=8211 \
    -e MULTITHREADING=true \
    -e RCON_ENABLED=true \
    -e RCON_PORT=25575 \
    -e ADMIN_PASSWORD="PASSWORD" \
    -e COMMUNITY=true \
    --restart unless-stopped \
    thijsvanloef/palworld-server-docker:latest
```

开启需要几分钟时间，开好后配置文件在./Pal/Saved/Config/LinuxServer/PalWorldSettings.ini

游戏大部分可调的配置都是在PalWorldSettings.ini中

建议先停止再修改配置文件

停止

```
docker stop pal
```

启动

```
docker start pal
```

查看日志

```
docker logs -f pal
```

### 配置文件修改

可视化的配置文件修改

https://github.com/knva/PalWorld_server_config

建议设置

```
死亡不掉落、孵蛋时间0、体力条10倍
```



### 守护脚本

由于服务器目前不稳定、可能需要一个守护脚本

https://github.com/Hoshinonyaruko/palworld-go

https://github.com/KirosHan/Palworld-server-protector

### 存档位置

```
./Pal/Saved/SaveGames/0/世界id/
```

玩家档案在

```
./Pal/Saved/SaveGames/0/世界id/Players/UID.sav
```

UID通常为Steam Id开头的十六进制UUID长度id 

### 非官方修复

目前官方的服务端非常吃内存，下面这个仓库尝试修复

https://github.com/VeroFess/PalWorld-Server-Unoffical-Fix

### 坏档修复

由于目前存档容易坏，参考下面的修复工具

https://github.com/xNul/palworld-host-save-fix

https://github.com/cheahjs/palworld-save-tools

### 作弊

由于目前游戏才发布、反作弊基本没有、等待



### 经验

关于一些人说帕鲁这游戏有点儿难
但是这游戏只要认真玩除了很肝，一点儿都不难
别人家牧场的东西，人不在，你可以随便去拿，反正溢出也是浪费
游戏里面的矿物是公共资源 哪怕别人圈地在附近，只要矿物刷新，你想去挖就挖 
别人把boss打残了，建议不要手贱去抢
会有刷新的时候的 Boss打不过可以卡地形 
新手村的猛犸象稳定产出 下去右边儿有一个狭窄的狭道刚好可以卡住猛犸象
请不要把基地刷在主要刷新帕鲁的地方 会导致帕鲁不再刷新
如果刷出流浪商人，建议打到血量低一点，然后用球一直抓
这样子不用外出就可以在家卖东西
最后一件事儿，如果进游戏之后建了基地想要退出公会，一定要三思 不要制造垃圾
补充说明如果你把你的基地建在一个孤立无援的山峰上面，敌袭是打不到你的 ，好像只会飞行系的（虽然这游戏的敌袭轻轻松松就可以应对）

### 配种

配种表和计算器

https://docs.qq.com/sheet/DT05PeVVoekZiamlh?tab=000001

### 互动地图

帕鲁群岛 - 幻兽帕鲁互动地图
https://map.caimogu.cc/palworld/paru_islands.html

### 其他可能有用的链接

https://github.com/jammsen/docker-palworld-dedicated-server

在线玩家列表

https://github.com/zaigie/palworld-server-tool

存档转移完全教程

https://github.com/GalileoFe/PalWorld-Save-Movement-Complete-Tutorio



# Star History

[![Star History Chart](https://api.star-history.com/svg?repos=PlexPt/awesome-palworld&type=Date)](https://star-history.com/#PlexPt/awesome-palworld&Date)
