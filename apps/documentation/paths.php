<?php
PathManager::setAppPrefix("/docs");

PathManager::loadPaths(
    array("", "index"),
    array("/tutorial", "tutorial"),
    array("/reference", "reference")
);
