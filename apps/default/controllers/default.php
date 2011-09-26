<?php
class DefaultController extends Controller {
    public function index() {
        // world changing code goes here
    }

    public function handleError($e, $code) {
        $this->assign("code", $code);
        return $this->render("error");
    }
}
