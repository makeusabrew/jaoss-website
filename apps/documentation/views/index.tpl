{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Documentation{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Documentation</h2>
    </div>

    <p>Documentation is currently split into two distinct areas. If you haven't used the
    framework before then you should follow the <a href="{$current_url}/tutorial">tutorial</a>,
    whereas if you're looking for detailed class-level documentation then you probably want
    the <a href="{$current_url}/reference">class reference</a>.</p>

    <div class='row'>
        <div class='span8'>
            <h3>Tutorial</h3>

            <p>The <a href="{$current_url}/tutorial">tutorial</a> walks you through installing, setting up, using &amp; developing
            a simple application and provides end-to-end coverage of every aspect of the <a href="https://github.com/makeusabrew/jaoss-web-template">framework</a>
            as a whole.</p>
        </div>
        <div class='span8'>
            <h3>Class Reference</h3>

            <p>The <a href="{$current_url}/reference">class reference</a> documents every class and method contained in the jaoss
            <a href="https://github.com/makeusabrew/jaoss">library</a>.</p>
        </div>
    </div>
{/block}
