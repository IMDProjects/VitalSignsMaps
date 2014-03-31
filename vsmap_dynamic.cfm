<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<!--- UPDATE - each page should have a unique title --->
    <title>I&amp;M Vital Signs Example Maps</title>
	
    <!--- LEAVE the following meta and link lines alone    --->
	<meta name="Description" content="National Park Service, Inventory &amp; Monitoring Program, Data Management" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="Keywords" content="National Park Service, national parks, natural resources, inventory, monitoring" />	 
	<link rel="icon" href="/im/assets/images/icons/nps/AH_small_flat_4C_12x16.png" type="image/png" />
	<link rel="stylesheet" type="text/css" href="/im/assets/css/imglobal.css" />    
    <!--[if lte IE 8]><link rel="stylesheet" type="text/css" href="/im/assets/css/IEGlobal.css" /><![endif]-->
    <!--- OPTIONAL ADD custom stylesheets below this point--->

	<!--- LEAVE the generic JQuery script alone --->
	<script type="text/javascript" src="/im/assets/scripts/JQuery/jquery-1.4.4.min.js"></script> 
	<!--- OPTIONAL ADD other scripts below this point  --->
	<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
	
	
        
<!--- LEAVE the lines below alone until the next "OPTIONAL UPDATE" comment below --->
</head>
<body>
    <div id="wrapper">
        <div id="page" class="clearfix">	
			<cfinclude template="/im/assets/includes/header.cfm">
			<cfset thisDiv = "IMD">
            
            <!--- OPTIONAL UPDATE - only required when this page will not be listed in the left-hand navigation.  To highlight/expand the parent folder/topic 
			page in the left-hand navigation, change the default "thisPage variable below (#CGI.script_name#) to the actual file name and path from the 
			server root of the parent page that you want highlighted/expanded in the left-hand navigation (e.g., "/im/datamgmt/index.cfm"). --->
			<cfset thisPage = #CGI.script_name#>  
			
            <div id="content" class="clearfix" >             
            <div class="hideInPrintView">
            
                	<!--- OPTIONAL UPDATE your breadcrumbs here  - suggest only two layers below I&M --->
                    <div class="breadcrumb"><a href="http://www.nps.gov">NPS</a> &raquo; 
						<a href="http://www.nature.nps.gov/index.cfm">Explore Nature</a> &raquo; <a href="/im/">I&amp;M</a> &raquo; GIS
					</div>
           </div>
             
            <!--- UPDATE the left-hand navigation for your site in the separate template include file below --->            
			<cfmodule template="/im/assets/includes/imNav.cfm" callingDiv="#thisDiv#" callingPage="#thisPage#">   
                <div class="main">
					<div class="article">           
                        
			 <!--- UPDATE - MAIN PAGE CONTENT STARTS HERE  --->
			<div class="intro">	
			<h1>Vital Signs Maps</h1>
			</div> 
            
            <p><b>Example maps of park and network vital sign protocols.</b></p>
            <center>
      		<select id="protocolsID" name="protocols" onChange="javascript:updateMap()">
      			<option> Choose a protocol: </option>
      			<option value="0"> Air Quality - Ozone </option>
      			<option value="1"> At-Risk Biota </option>
      			<option value="2"> Invasive or Exotic Plants </option>
      			<option value="3"> Visitor Use </option>
      		</select>
      		<br />

<div id="map" style="width: 750px; height: 500px"></div>	
<script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
<!-- Load Esri Leaflet -->
<script src="lib/esri-leaflet/esri-leaflet.js"></script>
<!-- <script src="leaflet-providers.js"></script> -->
			<!-- <script src="leaflet.js"></script> -->
			<script>
			/*
				var protocolServices = {
					"AirQualityOzone": "http://irmaservices.nps.gov/arcgis/rest/services/Tests/AirQualityOzoneProtocols/MapServer/",
					 "AtRiskBiota": "http://irmaservices.nps.gov/arcgis/rest/services/Tests/AtRiskBiotaProtocols/MapServer/",
					  "InvasiveExoticPlants": "http://irmaservices.nps.gov/arcgis/rest/services/Tests/InvasiveOrExoticPlantsProtocols/MapServer/", 
					  "VisitorUse": "http://irmaservices.nps.gov/arcgis/rest/services/Tests/VisitorUseProtocols/MapServer/"
				};
				*/
				var protocolServices = {
					names: ["AirQualityOzone", "AtRiskBiota", "InvasiveExoticPlants", "VisitorUse"],
					paths: ["http://irmaservices.nps.gov/arcgis/rest/services/Tests/AirQualityOzoneProtocols/MapServer/", "http://irmaservices.nps.gov/arcgis/rest/services/Tests/AtRiskBiotaProtocols/MapServer/", "http://irmaservices.nps.gov/arcgis/rest/services/Tests/InvasiveOrExoticPlantsProtocols/MapServer/", "http://irmaservices.nps.gov/arcgis/rest/services/Tests/VisitorUseProtocols/MapServer/"]
				}; 

				var map = L.map('map').setView([40.3, -105.5], 2);
				//Add Oceans Basemaps
				var defaultLayer = L.esri.basemapLayer("Oceans").addTo(map);
				//dynLayer = L.esri.dynamicMapLayer();

				function updateMap() {
					map.setView([40.3, -105.5], 2);
					//map.removeLayer(dynLayer);
					var x = $("#protocolsID").val();
					//alert(x);
					var servicePath = protocolServices.paths[x];
					//alert(servicePath);

					//ArcGIS Server Dynamic Map Service, Vital Signs Protocols
					dynLayer = L.esri.dynamicMapLayer(
						servicePath,
						 {
							opacity : 1,
							layers: [0]
						});
					//.addTo(map);
					//map.removeLayer(dynLayer);
					map.addLayer(dynLayer);
				}
				
				//var defaultLayer = L.tileLayer.provider('OpenStreetMap.Mapnik').addTo(map);
				
				//ArcGIS Server Dynamic Map Service, Historic Hurricane Tracks
				/*dynLayer = L.esri.dynamicMapLayer(protocolServices.paths[2], {
				opacity : 1,
				layers: [0]
				});

				map.addLayer(dynLayer);
				*/

				//Identifying Dynamic Map Service Features
				
      			map.on("click", function(e) {
        			dynLayer.identify(e.latlng, function(data) {
         				 if(data.results.length > 0) {
           				 	//Popup text should be in html format.  Showing the Storm Name with the type
            				//popupText =  "<b>" + (data.results[0].attributes.UnitCode) + "<b>";
            				popupText = "<table><tr><th colspan=2><b>" + (data.results[0].attributes.EntryValue) + "<b></th></tr><tr><td>" + (data.results[0].attributes.UnitCode) + "</td><td>" + (data.results[0].attributes.Title) + "</td></tr><tr><td colspan=2><a target=_new href=" + (data.results[0].attributes.ProtocolLink) + ">" + (data.results[0].attributes.ProtocolLink) + "</a></td></tr></table>"
            				//Add Popup to the map when the mouse was clicked at
            				var popup = L.popup()
              				.setLatLng(e.latlng)
              				.setContent(popupText)
              				.openOn(map);
              			};
              		});
        		});
              
			</script>            

			<div id="map" style="width: 700px; height: 500px"></div>
			
        
			<p class="top"><a href="#top">&uArr; To Top of Page</a></p>
                 
                     
             <!--- END of page content - NOTHING should be edited below this point --->  
            </div>
           </div>
          </div>
         </div>
		    <div class="DateLastModified">
			<cfdirectory action="list"
            	directory="#ExpandPath(".")#\"
                name="qGetLastdateModified"
                filter="#ListLast(CGI.SCRIPT_NAME, "/")#">
			<cfif qGetLastdateModified.recordCount>
				<cfoutput>Last Updated: #DateFormat(qGetLastdateModified.dateLastModified, "mmmm dd, yyyy")# </cfoutput>
			</cfif>
            <span style="margin-left: 20px;"><a href="/im/contact/contact.cfm"><strong>Contact Webmaster</strong></a></span>
            </div> 
			<cfinclude template="/im/assets/includes/footer.cfm">
		</div>
</div>
</body>
</html> 