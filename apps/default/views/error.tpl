{extends file='base.tpl'}
{block name="title"}{$smarty.block.parent} - Error{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Oops! That's a {$code}</h2>
    </div>
    {if $code == 404}
        <p>It looks like the page you're after doesn't exist - sorry about that. The site
        Try heading to the <a href="/">home page</a> and going from there. If you think this
        page should be here, please <a href="http://paynedigital.com/contact">let us know</a>. Thanks!</p>
    {else}
        <p>Sorry - there's been some sort of error. It looks like it was our fault - please
        try again in a minute.</p>
    {/if}
{/block}
