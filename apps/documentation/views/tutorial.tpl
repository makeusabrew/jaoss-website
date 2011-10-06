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
                        <li><a href="#models">Models</a>
                            <ol>
                                <li><a href="#objects">Objects</a></li>
                                <li><a href="#tables">Tables</a></li>
                                <li><a href="#a-note-on-data-persistence">A note on data persistence</a></li>
                                <li><a href="#crud-functionality-objects-vs-tables">CRUD functionality: Objects Vs Tables</a></li>
                                <li><a href='#defining-your-models-fields'>Defining your model's fields</a></li>
                            </ol>
                        </li>
                    </ol>
                </li>
                <li><a href="#a-more-advanced-app-latest-news">A more advanced app: Latest News</a>
                    <ol>
                        <li><a href="#dynamic-path-parameters">Dynamic path parameters</a></li>
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

                <p>We could discuss the concepts of models in a lot more detail, but let's just get stuck in with a
                real world example. Let's create a more advanced app which will deal with models and more advanced routing.</p>

                <h3 id='a-more-advanced-app-latest-news'>A more advanced app: Latest News</h3>

                <p>The app we just created was pretty boring, and not exactly very dynamic. Let's look at creating the staple of many websites;
                some news. To do this, we're going to want a model to represent our news stories, and some more dynamic routes to cater for the
                fact our data is also dynamic. Our news is going to be user generated - anyone can anonymously submit news providing they
                enter an email address*. We're going to need:</p>

                <ul>
                    <li>An 'add article' page</li>
                    <li>A 'view article' page</li>
                    <li>An index page showing snippets of the 5 most recently created articles</li>
                </ul>

                <p><small>*obviously, in a real application this would lead to complete carnage without some form of user authentication
                or article moderation - topics which are covered later.</small></p>

                <p>Let's drive straight in by creating our model to represent our articles:</p>

                <script src="https://gist.github.com/1266784.js"> </script>

                <p>Let's create the MySQL table to store our model. We're going to use the <a href="#cli-tools">CLI Tools</a> to do this,
                though of course we could just create it manually. Notice in the snippet below we manually pass the <code>PROJECT_MODE</code>
                environment variable as by default the CLI tools work in test mode, whereas we want to work in build mode for now. If you don't
                want to have to type <code>PROJECT_MODE=build</code>
                each time you invoke the cli tools you can of course run <code>export PROJECT_MODE=build</code> on a bash like shell.</p>

                <pre>nick@nick-desktop:~/www/demosite$ <code>PROJECT_MODE=build ./jcli create table Articles</code>
PROJECT_MODE set to build

Looking for model in project apps directory...
Found Articles model!
<span class='cli-error'>[PDOException] SQLSTATE[28000] [1045] Access denied for user 'youruser'@'localhost' (using password: YES)</span></pre>

                <p>Ah. That's not quite what we wanted to see. We haven't given jaoss our access credentials to our database yet so it's using
                the defaults found in <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/settings/live.ini#L11">settings/live.ini</a> which
                are of course incorrect. Rather than alter them directly, we're going to override the relevant settings in <code>settings/build.ini</code>
                since that's the mode we're working in. Create a database for your project if you haven't already (I'm using <code>demosite_build</code>) and then update
                build.ini:</p>

                <p class='alert-message block-message warning'>You should <strong>always</strong> create a new database user for each project you create and make sure
                it has <code>ALL PRIVILEGES</code> on the relevant database. <strong>Do not</strong> simply re-use your root login - for starters, everyone on
                the project probably has different root passwords (or they should!) and besides, you really don't want to expose this information
                anyway.</p>

                <script src="https://gist.github.com/1266856.js"> </script>

                <p>Let's run the <code>create table</code> command again. You should see something like:</p>

                <pre>nick@nick-desktop:~/www/demosite$ <code>PROJECT_MODE=build ./jcli create table Articles</code>
PROJECT_MODE set to build

Looking for model in project apps directory...
Found Articles model!
<span class='cli-success'>Table articles created on database [demosite_build]</span>
<span class='cli-success'>Don't forget to add this new table to any test fixtures!</span>
<span class='cli-success'>Done (0.082 secs)</span></pre>

                <p class='alert-message block-message info'>You can optionally pass the
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/cli/cmd/create.php#L144"><code>--output-only</code></a> flag to this command
                to see what SQL would be executed instead of actually running it. This is useful to verify that the table schema is as
                you'd expect it to be before committing to it.</p>

                <p>Perfect - we've now defined our basic model and created a database table to store it in. Let's dive in
                and create a path which will allow users to add articles to the site. While we're at it, we'll also create a placeholder 
                news controller and a placeholder view containing a form so a user can add an article:</p>

                <script src="https://gist.github.com/1266934.js"> </script>

                <p>If you load http://&lt;your-website&gt;.build/articles/add in your browser you should see your simple - and completely empty -
                form. Notice that you can submit the form and the page will still render even though the request method of the form is set to <code>POST</code>;
                by default, paths respond to any request method, though you can <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path_manager.php#L40">restrict this</a>.</p>

                <p>Let's turn our attention to that form, because without it we can't get very far. The framework ships with a useful
                helper in its default application called <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/apps/default/views/helpers/field.tpl">field.tpl</a>,
                which although not pretty to look at, is incredibly useful when dealing with forms and in particular forms which need to be
                generated based on a model's fields. Let's refactor our view it in incremental stages to shed a bit of light on how the
                field helper works. Firstly, let's add some fields in manually:</p>

                <script src="https://gist.github.com/1266967.js"> </script>

                <p>Refresh the page - you'll see a list of labels and text inputs corresponding to the field names
                you passed through when including each field template. Naturally, the label names and the
                field types aren't quite right, so let's sort that out:</p>

                <script src="https://gist.github.com/1266990.js"> </script>

                <p>Which should end up looking something like:</p>

                <img src="/img/add-article.png" alt="" />

                <p>We're getting there - but this probably all feels a little bit like déjà vu because we're pretty much
                just re-declaring the contents of our table's <code>columns</code> array. In fact, the first thing the field
                helper does is <a href="https://github.com/makeusabrew/jaoss-web-template/blob/master/apps/default/views/helpers/field.tpl#L1">look for a smarty variable</a>
                of that name, which if it finds it then uses to render the appropriate label, input type and attributes for the given
                field. Let's make that information available to smarty and refactor our view:</p>

                <script src="https://gist.github.com/1267007.js"> </script>

                <p>Notice that our view is now much simpler again - all we have to do is tell the field helper which field we're
                interesting in rendering, and it does the rest. The result looks like this:</p>

                <img src="/img/add-article-2.png" alt="" />

                <p>Perfect - we've even got the proper label names too. We're now ready to beef up our action to handle the post
                request, validate the user's input, and if it is, create a new article. If we do create a new article, we'll
                redirect the user straight to view it. If we don't, we'll render the form again and notify the user of any
                errors with their input. This entire flow is shown in the snippet below:</p>

                <script src="https://gist.github.com/1267055.js"> </script>

                <p>As you can see, without the over-commenting and unnecessary temporary variables (shown for clarity),
                the actual logic involved in this common flow is minimal.<p>

                <p class='alert-message block-message info'>If you're using a modern browser there's a good chance you
                won't even be able to submit the form if your input isn't valid. This is because the field helper uses
                HTML5 input attributes where possible, preventing you from submitting the form with empty / invalid
                data. If you want to verify your server-side error handling is working, try overriding the email field
                helper include with a type of 'text' and then entering an invalid email address. You'll hit the form again
                this time with the error rendered next to the input - this is taken care of by the field helper.</p>

                <p>Go ahead and fill out the form with some valid data and hit the submit button. Strangely, if everything
                worked you'll be greeted with a developer error, but fear not - this is only because we're trying to
                redirect to an action which doesn't exist yet (<code>view_article</code>). As a brief aside, let's take a look at
                the output in debug.log for a POST request to our add_article handler:</p>

                <pre>06/10/2011 11:22:13 (DEBUG)   - matched pattern [^/articles/add$] against URL [/articles/add] (location [apps/news] controller [News]
06/10/2011 11:22:13 (DEBUG)   - Init [NewsController-&gt;add_article]
06/10/2011 11:22:13 (DEBUG)   - Start [NewsController-&gt;add_article]
06/10/2011 11:22:13 (DEBUG)   - Validate::required(test) [title] - [OK]
06/10/2011 11:22:13 (DEBUG)   - Validate::required(this is my test article) [content] - [OK]
06/10/2011 11:22:13 (DEBUG)   - Validate::required(nick@paynedigital.com) [author_email] - [OK]
06/10/2011 11:22:13 (DEBUG)   - Validate::email(nick@paynedigital.com) [author_email] - [OK]
06/10/2011 11:22:13 (DEBUG)   - Article::setValues() returning [true] with error count [0]
06/10/2011 11:22:13 (WARN)    - Handling error of type [CoreException] with message [No Path found for options] and code [11]</pre>

                <p class='alert-message success'><strong>Remember:</strong> <code>tail -f log/debug.log</code> is your friend!</p>

                <p>So - our trusted users can now add articles to our website, but they can't yet see them. Let's tackle that next.</p>

                <h4 id='dynamic-path-parameters'>Dynamic path parameters</h4>

                <p>So, we need to create a path which will handle requests to view an actual article. Unlike those we've
                looked at thus far, this path is going to have to be able to accept a dynamic parameter - in this case,
                the ID of the article we wish to view. We do this using a combination of <a href="http://www.regular-expressions.info/">regular expressions</a>
                and <a href="http://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions#Features">named subpatterns</a>.
                You don't have to know a massive amount about either - in fact, the routes we've been
                entering prior to this point have simply been <a href="https://github.com/makeusabrew/jaoss/blob/master/library/path_manager.php#L130">simple regular expressions all along</a>
                - you just didn't know it. Let's add our new path now:</p>

                <script src="https://gist.github.com/1267112.js"> </script>

                <p>All we're doing is capturing a named sub pattern called <code>id</code> which, if matched, will always be an integer as denoted
                by <code>\d+</code>. Any sub patterns captured in your paths are available in your controller via the
                <a href="https://github.com/makeusabrew/jaoss/blob/master/library/controller.php#L89">getMatch</a> method. Let's create our new action
                and view to render our articles:</p>

                <script src="https://gist.github.com/1267146.js"> </script>

                <p>And voila!</p>

                <img src="/img/view-article.png" alt="" width="620" />

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
