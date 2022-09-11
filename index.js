const shell = require('shelljs');
const fs = require('fs');

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

shell.rm('-R', ['./public']);
shell.mkdir('public');
shellExec('resume export resume.pdf --format pdf --theme jsonresume-theme-straightforward', 'pdf creation failed', 0, 1);
shellExec('resume export resume.html --format html --theme jsonresume-theme-straightforward', 'pdf creation failed', 0, 1);
fs.writeFileSync('./public/index.html', html);
shell.mv('./resume.pdf', './Araf\ Al-Jami.pdf');
shell.cp('./Araf\ Al-Jami.pdf', './public/Araf\ Al-Jami.pdf');
shell.cp('./resume.html', './public/resume.html');