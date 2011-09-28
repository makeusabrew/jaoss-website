{extends file="base.tpl"}
{block name="title"}{$smarty.block.parent} - Open Source PHP5 Library &amp; Framework{/block}
{block name="body"}
    <div class='row'>
        <div class='span12'>
            <h2>What's JAOSS?</h2>
            <p><a href="https://github.com/makeusabrew/jaoss">JAOSS</a> is an open source, object oriented PHP5 library &amp; framework. Whilst
            the library can be used standalone, it is designed to be used as part of the <a href="https://github.com/makeusabrew/jaoss-web-template">JAOSS
            Web Template</a> framework to enable rapid, robust and testable web application development. The ethos of the project focusses on speed &#8212; of both development
            and code execution.</p>

            <p>Both the library and the framework are &#8212; and always will be &#8212; 100&#37; free and open source, released under the ultra permissive
            <a href="http://en.wikipedia.org/wiki/MIT_License">MIT License</a>. They are currently both <a href="https://github.com">hosted on GitHub</a>, the de-facto
            standard provider of open sourced, crowdsourced software projects.</p>

            <p>JAOSS once tenuously stood for Just Another Open Source System, but to be honest &#8216;System&#8217;
            really meant &#8216;PHP framework&#8217; anyway, so now it doesn't really stand for anything at all.</p>

            <p>For what it's worth, <a href="http://github.com/makeusabrew/jaoss-website">this site is built</a> on <a href="https://github.com/makeusabrew/jaoss-web-template">the
            framework</a>, though given that it's currently completely static, it really didn't have to be!</p>

            <h3>Quick Install</h3>
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

            <h3>Documentation</h3>
            <p>Please see the <a href="/docs">Documentation</a> section for further setup &amp; usage instructions.</p>
        </div>
        <div class='span4'>
            <h3>Author Information</h3>
            <p>This library &amp; framework are developed and maintained by <a href="http://twitter.com/makeusabrew">Nick Payne</a>,
            a PHP, JavaScript &amp; Mobile Application developer who currently runs <a href="http://paynedigital.com">Payne Digital</a>,
            a software development &amp; consultancy firm.</p>

            <a href="https://twitter.com/makeusabrew" class="twitter-follow-button" data-show-count="false">Follow @makeusabrew</a>
            <script src="//platform.twitter.com/widgets.js" type="text/javascript"></script>
        </div>
    </div>
{/block}
