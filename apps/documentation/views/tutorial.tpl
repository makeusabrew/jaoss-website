{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Documentation / Tutorial{/block}
{block name='head'}
    <link rel="stylesheet" href="/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
{/block}
{block name='body'}
    {include file='partials/warning_incomplete.tpl'}
    <div class='row'>
        <div class='span12'>
            <div class='page-header'>
                <h2>Tutorial</h2>
            </div>

            <ol>
                <li><a href="#getting-started">Getting Started</a></li>
                <li><a href="#project-configuration">Project Configuration</a>
                    <ol>
                        <li><a href="#virtualhost-setup">VirtualHost Setup</a></li>
                        <li><a href="#subfolder-setup">Subfolder Setup</a></li>
                        <li><a href="#directory-permissions">Directory Permissions</a></li>
                    </ol>
                </li>
                <li><a href="#project-modes">Project Modes</a></li>
                <li><a href="#settings">Settings</a></li>
                <li><a href="#creating-an-app">Creating an app</a>
                    <ol>
                        <li>Routes</li>
                        <li>Actions</li>
                        <li>Views</li>
                    </ol>
                </li>
                <li>A more advanced app
                    <ol>
                        <li>Models</li>
                        <li>Dynamic route parameters</li>
                    </ol>
                </li>
                <li>Sessions</li>
                <li>Cookies</li>
                <li>Testing
                    <ol>
                        <li>Test fixtures</li>
                        <li>Headless browser testing</li>
                        <li>Selenium testing</li>
                    </ol>
                </li>
                <li>Caching</li>
                <li>Logging</li>
                <li>CLI Tools</li>
            </ol>
            <div class='tutorial-content'>
                <h3 id='getting-started'>Getting Started</h3>

                <p>First things first - you'll need to grab the latest copy of the codebase. Follow
                the <a href="/#quickinstall" rel='quickinstall'>quick install</a> instructions to 
                clone the framework &amp; the library.</p>

                <h3 id='project-configuration'>Project Configuration</h3>

                <p>When developing a site you'll want to ensure you're in either <b>build</b> or
                <b>test</b> mode, both of which will enable developer friendly error
                messages and debug-level logging. The recommended way of doing this is to
                set up an Apache Virtualhost to house your newly created project.</p>

                <h4 id='virtualhost-setup'>VirtualHost Setup</h4>

    <pre>&lt;VirtualHost *:80&gt;
    ServerName jaoss-website.build
    ServerAlias jaoss-website.test
    SetEnvIf Host jaoss-website.build PROJECT_MODE=build
    SetEnvIf Host jaoss-website.test PROJECT_MODE=test

    DocumentRoot /var/www/jaoss-website/public

    &lt;Directory /var/www/jaoss-website/public&gt;
        DirectoryIndex index.php
        AllowOverride All
        Order allow,deny
        Allow from all
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
                
                <p>If you're using made up domains as in the example above, don't forget to
                add them to your <code>/etc/hosts</code> file and make sure the IP points
                to your webserver (127.0.0.1 if you're working locally).</p>

                <h4 id='subfolder-setup'>Subfolder Setup</h4>

                <p>If you can't be bothered to set up a VirtualHost, or you really want to run
                your project as a subfolder (say, on a Wordpress installation), then you'll have
                to add a <code>SetEnv</code> directive to the root folder's .htaccess file (<strong>not</strong>
                the one in the public folder). Just
                make sure you remove it when you deploy to a demo / live environment - the default
                mode if no environment variable is defined is live:</p>

    <pre># this will only ever kick in if the preferred VirtualHost set up hasn't been followed
# and the codebase is just being accessed directly in a subfolder. It's here as backup.
RewriteEngine On
RewriteRule ^(.*)$ public/$1 [L]
SetEnv PROJECT_MODE build
</pre>
                <p>Note that this approach has some big drawbacks in that the .htaccess file is version
                controlled, and it does now allow simultaneously running multiple modes. Unless you <em>need</em>
                the project to be a subfolder, the VirtualHost route is strongly recommended.</p>

                <h4 id='directory-permissions'>Directory Permissions</h4>

                <p>Your web user will need to be able to write to log/ and tmp/ (both relative to the project root).
                If you're set up in build mode when you first run your project with any luck you should get some nice
                developer friendly errors if either directory can't be written to, but if not then try making them
                writable and trying again. Once these are set up be sure to keep an eye on the logs in the log directory - it's
                recommended to always have a terminal open running <code>tail -f log/debug.log</code>.</p>

                <h3 id='project-modes'>Project Modes</h3>

                <p>There are five supported project modes, each of which inherits any <a href="#settings">settings</a> from
                the mode loaded before it - though these settings can be overridden at each level. The modes are as follows:</p>

                <ol>
                    <li>live</li>
                    <li>demo</li>
                    <li>build</li>
                    <li>test</li>
                    <li><abbr title="Continuous Integration">ci</a></li>
                </ol>

                <p>The mode your application is running in depends on the <code>PROJECT_MODE</code> environment variable set -
                see the earlier <a href="#project-configuration">Project Configuration</a> section for details on how to
                configure this.</p>

                <h3 id='settings'>Settings</h3>

                <p>On its own, <code>PROJECT_MODE</code> doesn't really mean a lot. Its core purpose is to control which
                of the <code>settings/*.ini</code> files are loaded. Settings are loaded in the order noted above up to and including
                the ini file matching the current mode. Therefore if your <code>PROJECT_MODE</code> is set to <code>build</code>,
                the framework will attempt to load (in order):</p>

                <ol>
                    <li>settings/live.ini</li>
                    <li>settings/demo.ini</li>
                    <li>settings/build.ini</li>
                </ol>

                <p>Consequently, if your <code>PROJECT_MODE</code> was <code>test</code>, settings/test.ini would be loaded as well, whereas
                if the mode was <code>live</code> then only settings/live.ini would be loaded.</p>
                
                <p>As noted earlier, settings cascade down through each mode such that those declared in the last loaded ini file
                will take precedence over any which have previously been loaded. This allows the bulk of the settings to be
                declared in settings/live.ini and refined at each level as required.</p>

                <h3 id='creating-an-app'>Creating an app</h3>

                <p>Once you've got a project set up you're ready to dive in - and where better than creating an app of your own? Before
                we do this, let's define exactly what we mean by an 'app' in the context of a jaoss project.</p>

                <blockquote>
                    <p>An app is a collection of one or more controllers, views, and / or models relating to one subject.</p>
                </blockquote>

                <p>The term <i>subject</i> covers quite a broad range - suitable examples would be a 'blog' app or a 'users' app. That said,
                apps deliberately do not railroad the developer down any particular path, so ultimately an app is whatever you choose
                it to be - your entire project <em>could</em> be one app - it would just be rather unweildy and you'd struggle to re-use
                many of its components in other projects.</p>

                <p>All of this leans towards treating apps almost as you would folders - the only restriction is that app folders should always
                be lowercase. Let's get on with it and create our first app folder and setting up some simple routing - 
                we're going to make a <em>very</em> basic 'static' app which will simply render some very basic views for known URLs. Let us begin:</p>

                <pre>nick@nick-desktop:~/www/demosite$ <code>mkdir static</code></pre>
                
                <p>Don't worry, it gets a little more involving than this...</p>

                <h4 id="routes">Routes</h4>

                <p>First things first - routes are referred to as
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path.php">paths</a> in the codebase. The terms
                are interchangeable, but we'll stick to paths in this tutorial to keep inline with the classes and methods you'll
                encounter when working with jaoss.</p>

                <p>One of the first things jaoss will do when processing a request is try to work out what apps to load, and what paths
                to load for each app. Unless you tell it any differently, it does this by looking for a <code>paths.php</code> file in each
                subfolder in the <code>apps/</code> directory. If it doesn't find this file it'll carry on regardless, though it will log
                to a notification log/verbose.log if you've got verbose logging enabled (you won't, yet).</p>

                <p>Let's create <code>paths.php</code> and add a single path to it. Add the following lines to<code>apps/static/paths.php</code>:</p>

                <pre><code>&lt;?php
PathManager::loadPaths(
    array("/about", "about")
);</code></pre>
            </div>
            

        </div>
        <div class='span4'>
            <div class='page-header'>
                <h3>Learning By Example</h3>
            </div>
            <p>There are several projects available on Github to learn from. Check out
            the <a href="https://github.com/makeusabrew/paynedigital.com">Payne Digital</a>
            source, the basic <a href="https://github.com/makeusabrew/jaoss-web-template">framework template</a> or even
            <a href="https://github.com/makeusabrew/jaoss-website">this website</a>.</p>

            <div class='page-header'>
                <h3>Code Reference</h3>
            </div>
            <p>Throughout this tutorial, many topics will link directly to the relevant class / folder / template
            relating to the discussion. These links are worth taking a look at in context to get a better understanding
            of what exactly the tutorial is describing. They will be shown <a class='github' href="https://github.com/makeusabrew">like this</a>.</p>
        </div>
    </div>
{/block}
{block name='script'}
    <script src="/js/jquery.1.6.4.min.js"></script>
    <script src="/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
    <script>
        $(function() {
            $("a[rel='quickinstall']").fancybox({
                "href"  : "/?quickinstall",
                "width" : 680,
                "height" : 270,
                "autoDimensions" : false
            });
            // have we got GA tracking on?
            if (typeof _gaq != 'undefined') {
                // if so, track links made in the table of contents
                $("ol li a[href^='#']").click(function(e) {
                    _gaq.push(['_trackEvent', 'Tutorial', $(this).html()]);
                });
            }
        });
    </script>
{/block}
