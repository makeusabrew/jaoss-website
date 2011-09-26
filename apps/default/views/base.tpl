<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-1.3.0.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    {include file='helpers/google_analytics.tpl'}
</head>
<body>
    <div id='header'>
        <div class='container'>
            <h1>JAOSS<small>.org</small></h1>
            {*<h2>Just Another Open Source System</h2>*}
            <h2>An Open Source PHP5 Library &amp; Web Application Framework</h2>
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
</body>
</html>
