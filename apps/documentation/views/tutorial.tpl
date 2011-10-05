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
                        <li><a href="#routes">Routes</a></li>
                        <li><a href="#actions">Actions</a></li>
                        <li><a href="#views">Views</a></li>
                    </ol>
                </li>
                <li><a href="#a-more-advanced-app-latest-news">A more advanced app: Latest News</a>
                    <ol>
                        <li><a href="#models">Models</a>
                            <ol>
                                <li><a href="#objects">Objects</a></li>
                                <li><a href="#tables">Tables</a></li>
                                <li><a href="#a-note-on-data-persistence">A note on data persistence</a></li>
                                <li><a href="#crud-functionality-objects-vs-tables">CRUD functionality: Objects Vs Tables</a></li>
                                <li><a href='#defining-your-models-fields'>Defining your model's fields</a></li>
                            </ol>
                        </li>
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

                <p>There are five supported <a href="https://github.com/makeusabrew/jaoss/blob/master/library/settings.php#L5">project modes</a>, each of which inherits any <a href="#settings">settings</a> from
                the mode loaded before it - though these settings can be overridden at each level. The modes are as follows:</p>

                <ol>
                    <li>live</li>
                    <li>demo</li>
                    <li>build</li>
                    <li>test</li>
                    <li><abbr title="Continuous Integration">ci</a></li>
                </ol>

                <p>The mode your application is running in depends on the <code>PROJECT_MODE</code>
                <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/public/index.php#L42">environment variable</a>
                set - see the earlier <a href="#project-configuration">Project Configuration</a> section for details on how to configure this.</p>

                <h3 id='settings'>Settings</h3>

                <p>On its own, <code>PROJECT_MODE</code> doesn't really mean a lot. Its core purpose is to control which
                of the <a href="https://github.com/makeusabrew/jaoss-web-template/tree/master/settings">settings/*.ini</a> files are loaded. Settings are loaded in the order noted above up to and including
                the ini file <a href="https://github.com/makeusabrew/jaoss/blob/master/library/settings.php#L33">matching the current mode</a>. Therefore if your <code>PROJECT_MODE</code> is set to <code>build</code>,
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
                declared in <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/settings/live.ini">settings/live.ini</a>
                and <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/settings/demo.ini">refined</a> at
                <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/settings/build.ini">each level</a> as required.</p>

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

                <p>One of the <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/public/index.php#L50">first things</a>
                jaoss will do when processing a request is try to work out what apps to load, and what paths
                to load for each app. It does this by <a href="https://github.com/makeusabrew/jaoss/blob/master/library/app.php#L15">looking for a paths.php</a>
                file in each subfolder in the <code>apps/</code> directory. If it doesn't find this file it'll carry on regardless, though it will 
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/app.php#L55">log</a> to log/verbose.log if you've got verbose
                logging enabled (you won't, yet).</p>

                <p>Let's create <code>paths.php</code> and add a single path to it. Add the following lines to <code>apps/static/paths.php</code>:</p>

                <script src="https://gist.github.com/1265692.js"> </script>

                <p>This snippet adds a path which will match a URL of /about (the first argument) to a controller action of the same name (the second
                argument). It takes additional optional arguments such as the controller to use and its location, which if omitted are worked out
                automagically based on the location of the paths.php file which was loaded.</p>

                <p>There are two main methods available for loading paths, though
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path_manager.php#L59">loadPaths</a> as used above is the
                most flexible and most consice (particularly when adding a large number of paths).</p>

                <p>The <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path_manager.php">Path Manager</a>
                object is responsible for loading all available paths for each app as well as
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/request.php#L94">matching</a> a
                request URL (e.g. /about) to a path. It also keeps track of which paths it's already tried to match - in short, it's
                a crucial part of a jaoss request.</p>

                <h4 id='actions'>Actions</h4>

                <p>Enough talk - head on over to http://&lt;your-website&gt;.build/about and see what happens. With any luck, you'll get
                a developer friendly error which says something like:</p>

                <pre><strong>Could not find controller class 'StaticController'</strong>

Controller class <strong>StaticController</strong> could not be found.

The path searched was <strong>/var/www/yoursite/apps/static/controllers/static.php</strong>.</pre>

                <p>Go ahead and create the file it's after in <code>apps/static/controllers/static.php</code>. Note that the filename
                is a <a href="https://github.com/makeusabrew/jaoss/blob/master/library/controller.php#L57">lowercased</a> version of
                the controller name, minus the 'controller' part since this is assumed from the fact the
                file is inside a 'controllers' directory. Populate your newly created file as follows:</p>

                <script src="https://gist.github.com/1265702.js"> </script>

                <p>Upon refreshing the page you should now be presented with a <b>Template Not Found</b> error which gives you
                a clear indication as to what jaoss was expecting to find. If your controller action does not explicitly return
                anything, jaoss will attempt to <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path.php#L33">render</a>
                a template matching the name of the action it just executed (in our case, <b>about.tpl</b>). Let's create that file now -
                the error should tell you where it was looking for it, the first of which should be <strong>/var/www/yoursite/apps/static/views</strong>,
                so we'll put it in there.</p>

                <h4 id='views'>Views</h4>

                <p>Jaoss uses the <a href="http://www.smarty.net/">Smarty</a> template engine to render views. There are no plans to support other
                mechanisms (such as <a href="http://twig.sensiolabs.org/">Twig</a>) just yet, though of course any forks are welcome to add this. Create
                <code>apps/static/views/about.tpl</code> and add some basic content to it:</p>

                <script src="https://gist.github.com/1265713.js"> </script>

                <p>Refresh the page and you should see the fruits of your labour, with the &lt;h1&gt; sporting the content you assigned
                from the controller.</p>

                <p>These three simple steps of creating a path, an action and a view don't seem like much but they pave the way for incredibly
                powerful, dynamic and flexible applications - and along with models form the backbone of any application you're likely to create.</p>

                <h3 id='a-more-advanced-app-latest-news'>A more advanced app: Latest News</h3>

                <p>The app we just created was pretty boring, and not exactly very dynamic. Let's look at creating the staple of many websites;
                some news. To do this, we're going to want a model to represent our news stories, and some more dynamic routes to cater for the
                fact our data is also dynamic. We'll expose a few URLs to our end users:</p>

                <ul>
                    <li>An index page showing snippets of the 5 most recently published articles</li>
                    <li>A full article page</li>
                    <li>An archive page showing old articles (we'll worry about what <i>old</i> means later).</li>
                </ul>

                <p>We'll start off by discussing models as they are implemented in the framework before moving on to
                create our own to represent news articles.</p>

                <h4 id='models'>Models</h4>

                <p>Models are, as in any <a href="http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller">MVC</a> framework, a fundamental
                part of most applications you'll make. This isn't the place to discuss what models are conceptually - but it is the place to discuss their
                implementation in jaoss, so let's do that. Each model you'll create is split into two distinct classes:</p>

                <ol>
                    <li><a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php">Objects</a> - a single entity - e.g. one person, one news article, one photo</li>
                    <li><a href="https://github.com/makeusabrew/jaoss/blob/master/library/table.php">Tables</a> - a collection of objects</li>
                </ol>

                <h5 id='objects'>Objects</h5>

                <p>An object &mdash; a single entity &mdash; knows how to do things relating to itself, but not its peers. For example, an object might declare a method
                <code>getDisplayName()</code> which might try and return a friendly name for a person (e.g. Nick Payne, or Nick, or @makeusabrew if I hadn't entered my full details).
                It would <strong>not</strong>, however, declare a method called <code>findByName($forename, $surname)</code> - this should instead be left to the model's
                corresponding <a href='#tables'>Table</a>.</p>

                <p>Objects <em>do</em> know how to create, update or delete their equivalent row in the database table which represents them via their
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php#L142">save</a> and
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php#L184">delete</a> methods.</p>

                <h5 id='tables'>Tables</h5>

                <p>A table represents the concept of a collection of objects. As such, the vast majority of methods you'll declare in your table
                will be similar to <code>findBy...()</code> or <code>getBy...()</code> (no particular naming convention is enforced) which will in
                most cases return an array of <a href="#objects">Objects</a>. Principally, table methods deal with
                reading either single or multiple objects.</p>

                <h5 id='a-note-on-data-persistence'>A note on data persistence</h5>

                <p>One area where you may find jaoss differs to other frameworks is the fairly tight coupling between models and the data storage
                underpinning them - the only currently supported mapping being to a MySQL database. In general, tight coupling is bad,
                but jaoss is a framework driven by necessity, and thus far decoupling models from their database backend has not been
                necessary. Additionally, <a href="http://en.wikipedia.org/wiki/Create,_read,_update_and_delete">CRUD</a>
                functionality is not isolated to one class or the other, hence they are both database aware. This behaviour
                is discussed above and summarised in the following table:</p>

                <h5 id='crud-functionality-objects-vs-tables'><a href="http://en.wikipedia.org/wiki/Create,_read,_update_and_delete">CRUD</a> functionality: Object Vs Table</h5>

                <table>
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Class</th>
                            <th>DB Method(s)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Create</strong></td>
                            <td>Object</td>
                            <td><a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php#L142">save</a></td>
                        </tr>
                        <tr>
                            <td><strong>Read</strong></td>
                            <td>Table</td>
                            <td><a href="https://github.com/makeusabrew/jaoss/blob/master/library/table.php#L158">read</a>,
                            <a href="https://github.com/makeusabrew/jaoss/blob/master/library/table.php#L129">find</a>,
                            <a href="https://github.com/makeusabrew/jaoss/blob/master/library/table.php#L97">findAll</a> <small>+ your own</small></td>
                        </tr>
                        <tr>
                            <td><strong>Update</strong></td>
                            <td>Object</td>
                            <td><a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php#L142">save</a></td>
                        </tr>
                        <tr>
                            <td><strong>Delete</strong></td>
                            <td>Object</td>
                            <td><a href="https://github.com/makeusabrew/jaoss/blob/master/library/object.php#L184">delete</a></td>
                        </tr>
                    </tbody>
                </table>

                <p>This might lead you to think that the responsibilities are somewhat skewed and that the Table class
                is rather superflous - but it has one key property which is the corner stone of all models:
                the <a href="https://github.com/makeusabrew/jaoss/blob/master/library/table.php#L11">$meta</a> array.
                It's this array which holds the definition for the fields (or columns) which represent and define your
                model's data.</p>

                <h5 id='defining-your-models-fields'>Defining your model's fields</h5>

                <p>You define your model's fields as a nested array inside your table's <code>$meta</code> array. Arguably, these fields
                could be declared as a property of the object instead - after all, it's objects which actually have
                fields with values populated from database tables. However, therein lies the point: if you've got an object
                then you want <em>data</em>, not <a href="http://en.wikipedia.org/wiki/Metadata"><em>data about data</em></a>.
                Similarly it is the (database) table which physically defines the fields we can store, so it is the (model) Table
                which defines them in our application. Lastly, if you have an array of hundreds or thousands of objects, the
                last thing you need is a useless array of meta data duplicated across each and every one.</p>

                <p>Fields should never be declared <b>directly</b> inside the meta array - instead they should be declared in
                a namespaced <code>columns</code> array to allow for other meta data to be added in future*.
                For example:</p>

                <script src="https://gist.github.com/1265672.js"> </script>

                <p><small>* this is pretty much the only example of 'we might need this...' you'll find in the framework. Everything
                else is there because it <strong>is used</strong>.</small></p>

                <p>A list of available column types and other keys is discussed later - the important aspect for now is to remember
                that fields must be declared within a <code>columns</code> array.</p>

                <p>We could discuss the concepts of models in a lot more detail, but let's just get stuck in and get back to our
                real world example. Let's create a model to represent our news articles.</p>

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
            of what exactly the tutorial is describing. They will be shown <a title='The Octocat denotes a link to Github' href="https://github.com/makeusabrew/jaoss">like this</a>.</p>
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
                    _gaq.push(['_trackEvent', 'Tutorial', 'Internal', $(this).html()]);
                });

                $(".tutorial-content a[href^='https://github.com/makeusabrew/jaoss']").click(function(e) {
                    _gaq.push(['_trackEvent', 'Tutorial', 'External',  $(this).attr("href")]);
                });
            }
        });
    </script>
{/block}
