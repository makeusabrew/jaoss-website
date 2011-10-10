<?php
class Cli_Generate extends Cli {

    public function run() {
        $this->docs();
    }

    protected function docs() {
        $this->writeLine("Generating class documentation");
    }
}
