# AC-AddSubDomain

 ```
 sudo apt-get install jq
 ```
 
 ```
 sudo apt install curl
 ```
 
 ```
 git clone https://github.com/AC-Lover/AC-AddSubDomain.git
 ```
 
Edit `cofing.json`

run `addsubdomain.sh`


## دریافت API Token

برای دریافت گواهی SSL چند روش وجود دارد. در حالت `standalone` باید پورت 80 سرور آزاد باشد. در صورتی که شما از این پورت استفاده میکنید باید هنگام دریافت گواهی سرویس استفاده کننده را خاموش کنید و پس از دریافت گواهی دوباره فعال نمایید. همچنین در زمان تمدید گواهی باید دوباره این مراحل را تکرار کنید. اگر از کلاودفلر برای مدیریت دامنه خود استفاده کنید میتوان به وسیله `API Token` و `DNS Challenge` گواهی را دریافت کرد در این حالت دیگر لازم نیست پورت 80 آزاد باشد.

به داشبورد اصلی برگردید و مطابق عکس زیر وارد پروفایل خود شوید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf016.png)

مطابق عکس زیر ابتدا روی `API Tokens` و سپس روی `Create Token` کلیک کنید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf017.png)

مطابق عکس زیر `Edit Zone DNS` را انتخاب کنید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf018.png)

مطابق عکس زیر موارد 1 تا 5 را انتخاب کنید و در شماره 6 دامنه خود را انتخاب کرده و در نهایت روی شماره 7 کلیک کنید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf019.png)

مطابق عکس زیر بر روی `Create Token` کلیک کنید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf020.png)

توکن خود را در جایی امن کپی کنید. در مرحله دریافت گواهی از آن استفاده میکنیم. دقت کنید در صورت گم کردن توکن دیگر امکان کپی کردن دوباره آن وجود ندارد و باید توکن جدید دریافت کنید.

![cloudflare add site](https://github.com/rahgozar94725/freedom/blob/main/src/cf021.png)

این توکن را کپی کرده و در فایل `config.json` بجای `<CloudFlare TOKEN>` قرار می دهید
