const shell = require('shelljs');

const shellExec = (command, errorMessage, exitCode, errorCode) => {
    if (shell.exec(command).code != exitCode) {
        shell.echo(errorMessage);
        shell.exit(errorCode);
    }
}

shell.rm('-R', ['./public']);
shell.mkdir('public');
shellExec('pdflatex main', 'pdf creation failed', 0, 1);
shell.mv('./main.pdf', './Araf\ Al-Jami.pdf');
shell.cp('./Araf\ Al-Jami.pdf', './public/Araf\ Al-Jami.pdf');