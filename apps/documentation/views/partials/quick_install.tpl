<h3 id='quickinstall'>Quick Install</h3>
<ol>
    <li><code>git clone --recursive git://github.com/makeusabrew/jaoss-web-template.git <strong>my_new_folder</strong></code></li>
    <li><code>cd my_new_folder</code></li>
    <li><code>rm -rf .git/</code> (the trailing slash is important - you don't want to remove .gitmodules or .gitignore)</li>
    <li><code>git init</code></li>
    <li><code>git add .</code></li>
    <li><code>git commit -m "<strong>initial commit</strong>"</code></li>
</ol>
<p>Completing the above steps will give you a clean <a href="https://github.com/makeusabrew/jaoss-web-template">project template</a>
to work with, as well as a <a href="http://book.git-scm.com/5_submodules.html">submodule</a>
which will always point to the latest stable revision of the <a href="https://github.com/makeusabrew/jaoss">library</a>.
Assuming <strong>my_new_folder</strong> is under your web server's document root, you should be able to navigate
to it in your browser and receive the customary <b>Hello world!</b> welcome page.</p>
