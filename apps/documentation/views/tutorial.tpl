{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Documentation / Tutorial{/block}
{block name='head'}
    <link rel="stylesheet" href="/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Tutorial</h2>
    </div>
    <ol>
        <li>Getting Started</li>
    </ol>
    <div class='row'>
        <div class='span12'>
            <h3>Getting Started</h3>

            <p>First things first - you'll need to grab the latest copy of the codebase. Follow
            the <a href="/#quickinstall" rel='quickinstall'>quick install</a> instructions on the
            to clone the framework &amp; the library.</p>
        </div>
        <div class='span4'>
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
                "autoDimensions" : false
            });
        });
    </script>
{/block}
