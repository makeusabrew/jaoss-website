<?php
class DefaultController extends Controller {
    public function index() {
        if ($this->request->isAjax() &&
            $this->request->getVar('quickinstall') !== null) {

            $this->request->disableAjax();
            return $this->render("documentation/views/partials/quick_install");
        }
    }

    public function handleError($e, $code) {
        $this->assign("code", $code);
        return $this->render("error");
    }
}
