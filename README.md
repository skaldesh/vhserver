### Build
```bash
docker build -t linuxgames/vhserver:<tag> .
```

### Run
```bash
docker run \
    --daemon \
    -p 2456:2456/udp \
    -p 2457:2457/udp \
    -v "/path/to/vhserver.cfg:/home/vhserver/linuxgsm/lgsm/config-lgsm/vhserver/vhserver.cfg" \
    -v "/path/to/vhdatadir:/home/vhserver/.config/unity3d/IronGate/Valheim" \
    linuxgames/vhserver:<tag>
```

### Config
You can find parameters to configure the vhserver here (inside the Container):  
`/home/vhserver/linuxgsm/lgsm/config-default/config-lgsm/vhserver/_default.cfg`  
Apply them to the `vhserver.cfg` file that gets mounted.

### Copy Game Data
Copy for example from a Windows machine this folder:  
`C:\Users\(Your PC Username)\AppData\LocalLow\IronGate\Valheim\worlds`  
and mount it in the container (`vhdatadir` in the Run section above).

### Links
- Install instructions: https://linuxgsm.com/lgsm/vhserver/
- Install & Setup instructions: https://unsere-schule.org/hardware/server/valheim-server-einrichten/
