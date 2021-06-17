


<h1 class="code-line" data-line-start=0 data-line-end=1><a id="title"></a>MxM Duty</h1>
<h2 class="code-line" data-line-start=1 data-line-end=2><a id="site"></a><a href="https://fenixhub.dev">https://fenixhub.dev</a></h2>
<h1 class="code-line" data-line-start=3 data-line-end=4><a id="Dependencies_3"></a>Dependencies</h1>
<ul>
   <li class="has-line-data" data-line-start="4" data-line-end="5">mysql-async</li>
   <li class="has-line-data" data-line-start="5" data-line-end="7">es_extended (Tested on v1 Final)</li>
</ul>
<h1 class="code-line" data-line-start=7 data-line-end=8><a id="Noteworthy_Features_7"></a>Noteworthy Features</h1>
<h2 class="code-line" data-line-start=8 data-line-end=9><a id="Duty"></a>Duty Sistem</h2>
<p class="has-line-data" data-line-start="9" data-line-end="13"> Unlike the classic duty system that sets a new job, this system works with a simple variable that is saved in the database.</p>
<h2 class="code-line" data-line-start=14 data-line-end=15><a id="Configurable"></a>Configurable</h2>
<p class="has-line-data" data-line-start="15" data-line-end="17">Very easy to configure, and usable for any job</p>
<h2 class="code-line" data-line-start=18 data-line-end=19><a id="resmon"></a>Optimization</h2>
<p class="has-line-data" data-line-start="19" data-line-end="21">The script has been created in order to create the least amount of lag both client and server side</p>
<h1 class="code-line" data-line-start=26 data-line-end=27><a id="ConfigSetting"></a>Example Usage and Config</h1>
<h2 class="code-line" data-line-start=28 data-line-end=29><a id="permission"></a>Config Setting</h2>
<pre><code class="has-line-data" data-line-start="30" data-line-end="38" class="language-lua"><span class="hljs-comment">--config.lua :</span>
Position = {
    { job = "polizia", grademin = 0, x = 441.06674194336, y = -978.576171875, z = 30.689609527588}
}
 <span class="hljs-comment">--put on job the job that the marker can see, in grademin the minimum grade of the job that the marker can see and in x, y, z, the marker position</span>
</code></pre>
<h2 class="code-line" data-line-start=39 data-line-end=40><a id="Permission"></a>Examples of use (Server Side) </h2>
<pre><code class="has-line-data" data-line-start="43" data-line-end="53" class="language-lua">

 -- Request Code
if ExampleChekJobInDutyOnline("police") > 1 then   <span class="hljs-comment">--As argument put the job to check</span>
<span class="hljs-comment">--in this case the "ExampleChekJobInDutyOnline" function gives you the number of "police" online and in service, useful for carrying out checks for robberies or for paycheck</span>
end

</code></pre>
<pre><code class="has-line-data" data-line-start="43" data-line-end="53" class="language-lua">
-- Function
ExampleChekJobInDutyOnline = function (job)  
    local count = 0
    for index, player in pairs(GetPlayers()) do
        if tonumber(player) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local inDuty = exports["mxm_duty"]:getDuty(tonumber(player))
            if xPlayer then
                if xPlayer.job.name == job and inDuty then
                    count = count + 1
                end
            end
        end
    end
    return count
end
</code></pre>

<h2 class="code-line" data-line-start=59 data-line-end=60><a id="Vehicle"></a>Examples of use (Client Side)</h2>
<p class="has-line-data" data-line-start="60" data-line-end="61"></p>
<pre><code class="has-line-data" data-line-start="62" data-line-end="64" class="language-lua"><span class="hljs-keyword">local inDuty = exports["mxm_duty"]:getClienDuty()
if  inDuty  then
<span class="hljs-string">--print("in Duty")</span>   
else
<span class="hljs-string">--print("Off Duty")</span>   
end</span>
</code></pre>

<h2 class="code-line" data-line-start=70 data-line-end=71><a id="Credits"></a>Credits</h2>
<p class="has-line-data" data-line-start="71" data-line-end="73">The publication of the script does not authorize its commercialization. if you have any advice or want to propose changes you can contact us via discord<br>  
<pre><code class="has-line-data" data-line-start="75" data-line-end="80" class="language-lua"></code>
  <span class="hljs-string">"Main Developer:"   </span> <span class="hljs-comment">MaXxaM#0511</span>
  <span class="hljs-string">"Powered By"       </span> <span class="hljs-comment">fenixhub.dev</span>

</code></pre>
</body></html>
