{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Documentation / Tutorial{/block}
{block name='head'}
    <link rel="stylesheet" href="/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
{/block}
{block name='body'}
    <div class='row'>
        <div class='span12'>
            <div class='page-header'>
                <h2>Tutorial</h2>
            </div>

            <ol>
                <li>Getting Started</li>
                <li>Project Configuration</li>
            </ol>
            <h3>Getting Started</h3>

            <p>First things first - you'll need to grab the latest copy of the codebase. Follow
            the <a href="/#quickinstall" rel='quickinstall'>quick install</a> instructions to 
            clone the framework &amp; the library.</p>

            <h3>Project Configuration</h3>

            <p>When developing a site you'll want to ensure you're in either <b>build</b> or
            <b>test</b> mode, both of which will enable developer friendly error
            messages and debug-level logging. The recommended way of doing this is to
            set up an Apache Virtualhost to house your newly created project:</p>

<pre><code>&lt;VirtualHost *:80&gt;
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
&lt;/VirtualHost&gt;</code></pre>
            
            <p>If you're using made up domains as in the example above, don't forget to
            add them to your <code>/etc/hosts</code> file and make sure the IP points
            to your webserver (127.0.0.1 if you're working locally).</p>

        </div>
        <div class='span4'>
            <div class='page-header'>
                <h3>Learning By Example</h3>
            </div>
            <p>There are several projects available on Github to learn from. Check out
            the <a href="https://github.com/makeusabrew/paynedigital.com">Payne Digital</a>
            source, the basic <a href="https://github.com/makeusabrew/jaoss-web-template">framework template</a> or even
            <a href="https://github.com/makeusabrew/jaoss-website">this website</a>.</p>
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
        });
    </script>
{/block}
