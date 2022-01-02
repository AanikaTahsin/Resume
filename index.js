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

const resumeHtml = 
`<html>
    <head>
        <script>
        </script>
    </head>
    <body>
        <div style="margin: 0 auto; max-width: 55rem;">
        ${fs.readFileSync('./resume.html')}
        </div>
    </body>
</html>`

shell.rm('-R', ['./public']);
shell.mkdir('public');
shellExec('pdflatex main', 'pdf creation failed', 0, 1);
fs.writeFileSync('./public/index.html', html);
fs.writeFileSync('./public/resume.html', resumeHtml);
shell.mv('./main.pdf', './Araf\ Al-Jami.pdf');
shell.cp('./Araf\ Al-Jami.pdf', './public/Araf\ Al-Jami.pdf');
// shell.cp('./resume.html', './public/resume.html');