<?php
PathManager::setAppPrefix("/docs");
PathManager::setAppCacheTtl(600);

PathManager::loadPaths(
    array("", "index"),
    array("/tutorial", "tutorial"),
    array("/reference", "reference")
);
