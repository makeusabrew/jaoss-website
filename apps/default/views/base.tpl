<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-1.3.0.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/main.css">
</head>
<body>
    <div id='header'>
        <div class='container'>
            <h1>JAOSS<small>.org</small></h1>
            {*<h2>Just Another Open Source System</h2>*}
            <h2>Open Source PHP5 Library &amp; Web Application Framework</h2>
        </div>
    </div>
    <div class='topbar'>
        <div class='topbar-inner'>
            <div class='container'>
                <h3><a href='/'>jaoss.org</a></h3>
                <ul class='nav'>
                    <li><a href="/">Home</a></li>
                    {*
                    <li><a href="/about">About</a></li>
                    *}
                    <li><a href="https://github.com/makeusabrew/jaoss">The Library</a></li>
                    <li><a href="https://github.com/makeusabrew/jaoss-web-template">The Framework</a></li>
                    <li><a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/README.md">Documentation</a></li>
                </ul>
                {*
                <form action="/search" method="get">
                    <input type="text" name="q" placeholder="Search" />
                </form>
                *}
            </div>
        </div>
    </div>
    <div class='container'>
        {block name="body"}<p>Your body content goes here.</p>{/block}
    </div>
    <div id='footer'>
        <div class='well'>
            &copy; 2010 - 2011 <a href="http://paynedigital.com">Payne Digital Ltd</a>
        </div>
    </div>

    {*
      ordinarily body will probably be wrapped with surrounding markup, so it
      makes sense to have a separate block to put script tags in
     *}
    {block name="script"}{/block}

    {* default tracking is GA *}
    {setting value="analytics.enabled" assign="stats_enabled"}
    {if $stats_enabled}
        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', '{setting value="analytics.account_no"}']);
            _gaq.push(['_setDomainName', 'none']);
            _gaq.push(['_setAllowLinker', true]);
            _gaq.push(['_trackPageview']);

            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();

        </script>
    {/if}
</body>
</html>
