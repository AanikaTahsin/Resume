const shell = require('shelljs');
const fs = require('fs');
const puppeteer = require('puppeteer');

const shellExec = (command, errorMessage, exitCode, errorCode) => {
    if (shell.exec(command).code != exitCode) {
        shell.echo(errorMessage);
        shell.exit(errorCode);
    }
}

const ms = new Date().getTime();
const html = 
`<html>
    <head>
        <meta http-equiv="Refresh" content="0; URL=./Araf Al-Jami.pdf?=${ms}">
        <script>
            window.location = "./Araf Al-Jami.pdf?=${ms}";
        </script>
    </head>
    <body>
        loading...
    </body>
</html>`;

(async () => {
    shell.rm('-R', ['./public']);
    shell.mkdir('public');
    shellExec('resume export resume.html --format html --theme jsonresume-theme-straightforward', 'pdf creation failed', 0, 1);
    fs.writeFileSync('./public/index.html', html);

    const browser = await puppeteer.launch({
        executablePath: process.env.PUPPETEER_EXECUTABLE_PATH
    });

    const page = await browser.newPage();

    await page.setContent(fs.readFileSync('./resume.html', 'utf-8'));

    await page.pdf({
      path: 'resume.pdf',
      format: 'A4',
      printBackground: true,
    });

    await browser.close();
    
    shell.mv('./resume.pdf', './Araf\ Al-Jami.pdf');
    shell.cp('./Araf\ Al-Jami.pdf', './public/Araf\ Al-Jami.pdf');
    shell.cp('./resume.html', './public/resume.html');
    shell.cp('./resume.json', './public/resume.json');
})();