# GitHub Server aur Database Setup — Hindi

Yeh guide `devops-saurabhpandey/github-server-platform` ke liye hai.

## Sabse zaroori baat

- GitHub repository source code rakhti hai; GitHub apne aap aapka 24x7 server nahi banta.
- Is repository mein Docker Compose ki shared foundation hai: Caddy, Portainer aur Uptime Kuma.
- Is configuration ko chalane ke liye Docker Engine/Compose chalane wala computer ya server zaroori hai.
- Sirf Android phone par GitHub files edit kar sakte hain, lekin is repo ka Docker Compose stack Android se seedha 24x7 host nahi hoga.
- Monthly hosting fee se bachne ke liye apne Windows PC ko baad mein Docker Desktop ke saath host banaya ja sakta hai. PC band/sleep, internet ya bijli band hui to app offline ho sakta hai.
- Abhi koi live server start ya public deployment nahi hua hai.

## Apps ko alag rakhenge

| App | GitHub repository | Data isolation |
|---|---|---|
| SHIVASHA | `devops-saurabhpandey/shivasha` | Apna MongoDB service/volume aur credentials |
| KTL Daily Tasks | `devops-saurabhpandey/KTL-Daily-Tasks` | Is app ke actual code ko dekh kar database decide hoga |
| KTL CRM | `devops-saurabhpandey/KTL-PVT-LTD-` | Is app ke actual code ko dekh kar database decide hoga |

KTL apps ko SHIVASHA ke database ya container mein merge nahi karna hai. KTL apps ka database technology source code inspect kiye bina assume nahi ki jayegi.

## Android par abhi kya kar sakte hain

1. GitHub mein is repository ko kholen:
   `https://github.com/devops-saurabhpandey/github-server-platform`
2. `Actions` tab mein workflow ka result dekhen. Green check ka matlab validation/build successful ho sakta hai; iska matlab live server chalu hona nahi hai.
3. Kisi bhi file mein password, JWT secret, MongoDB URI with password, GitHub token ya user data commit na karein.
4. Is repo ke `.env.example` ko seedha `.env` naam se GitHub par upload na karein. Real `.env` sirf host computer par rahe.

## Jab Windows PC par server chalana ho

1. Windows PC par Docker Desktop install karein aur Docker Engine start karein.
2. Is repository ko PC par clone/download karein.
3. Repository folder mein terminal khol kar `.env.example` se local `.env` banayein. Local `.env` GitHub par commit na karein.
4. Pehle configuration validate karein:
   ```powershell
   docker compose config
   ```
5. Shared tools start karein:
   ```powershell
   docker compose up -d
   docker compose ps
   ```
6. Logs dekhein:
   ```powershell
   docker compose logs --tail=100
   ```
7. Band karne ke liye:
   ```powershell
   docker compose down
   ```

Agar ports 80/443 pehle se use ho rahe hon to local `.env` mein `HTTP_PORT` aur `HTTPS_PORT` ko available ports par set karein. Public internet par admin panel ya database port seedha expose na karein.

## SHIVASHA MongoDB

SHIVASHA ke repository mein pehle se `docker-compose.yml` hai, jisme MongoDB service aur `shivasha_mongo_data` named volume configured hai. Use alag Compose project ke roop mein chalana hai; is shared platform ka `compose.yaml` SHIVASHA database ka replacement nahi hai.

SHIVASHA ko run karne se pehle:
1. Repository ke current `docker-compose.yml`, backend environment variables, health endpoint aur Dockerfiles ko review karein.
2. Production secrets ke liye strong unique values sirf local `.env` mein set karein.
3. App ko alag project name se start karein, taaki KTL services/volumes se clash na ho.
4. Health endpoint, logs aur database persistence test karein.
5. Data ka backup alag drive par rakhein aur restore test karein.

## Abhi ka status

- [x] Shared platform configuration files GitHub mein hain.
- [x] App-isolation guidance documented hai.
- [ ] Aapke actual computer par Docker Engine chalana.
- [ ] Shared stack ko computer par start aur test karna.
- [ ] SHIVASHA ko local host se connect karke health/database persistence verify karna.
- [ ] KTL Daily Tasks aur KTL CRM ke source code ke hisaab se unke deployment/database setup ko confirm karna.
- [ ] Public access/domain/secure tunnel configure karna, agar baad mein chahiye.

Jab tak actual host par commands run aur test na ho jaayen, setup ko live/complete na samjhein.
