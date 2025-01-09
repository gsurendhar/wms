var wms_layers = [];
var format_Bihar_State_0 = new ol.format.GeoJSON();
var features_Bihar_State_0 = format_Bihar_State_0.readFeatures(json_Bihar_State_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Bihar_State_0 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Bihar_State_0.addFeatures(features_Bihar_State_0);var lyr_Bihar_State_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Bihar_State_0, 
                style: style_Bihar_State_0,
                title: '<img src="styles/legend/Bihar_State_0.png" /> Bihar_State'
            });var format_Bihar_AWSmasterdata_1 = new ol.format.GeoJSON();
var features_Bihar_AWSmasterdata_1 = format_Bihar_AWSmasterdata_1.readFeatures(json_Bihar_AWSmasterdata_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Bihar_AWSmasterdata_1 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Bihar_AWSmasterdata_1.addFeatures(features_Bihar_AWSmasterdata_1);var lyr_Bihar_AWSmasterdata_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Bihar_AWSmasterdata_1, 
                style: style_Bihar_AWSmasterdata_1,
                title: '<img src="styles/legend/Bihar_AWSmasterdata_1.png" /> Bihar_AWS master data'
            });

lyr_Bihar_State_0.setVisible(true);lyr_Bihar_AWSmasterdata_1.setVisible(true);
var layersList = [lyr_Bihar_State_0,lyr_Bihar_AWSmasterdata_1];
lyr_Bihar_State_0.set('fieldAliases', {'ID_0': 'ID_0', 'ISO': 'ISO', 'NAME_0': 'NAME_0', 'ID_1': 'ID_1', 'NAME_1': 'NAME_1', 'ID_2': 'ID_2', 'NAME_2': 'NAME_2', 'TYPE_2': 'TYPE_2', 'ENGTYPE_2': 'ENGTYPE_2', 'NL_NAME_2': 'NL_NAME_2', 'VARNAME_2': 'VARNAME_2', });
lyr_Bihar_AWSmasterdata_1.set('fieldAliases', {'ClientID': 'ClientID', 'District': 'District', 'Block': 'Block', 'Location': 'Location', 'Latitude': 'Latitude', 'Longitude': 'Longitude', 'Rain (mm)': 'Rain (mm)', 'Temperature( �C )': 'Temperature( �C )', 'Humidity(%)': 'Humidity(%)', 'Wind Speed( m/sec )': 'Wind Speed( m/sec )', 'Wind Direction( degrees)': 'Wind Direction( degrees)', 'Local Pressure( mb )': 'Local Pressure( mb )', 'Solar Radiation': 'Solar Radiation', });
lyr_Bihar_State_0.set('fieldImages', {'ID_0': 'TextEdit', 'ISO': 'TextEdit', 'NAME_0': 'TextEdit', 'ID_1': 'TextEdit', 'NAME_1': 'TextEdit', 'ID_2': 'TextEdit', 'NAME_2': 'TextEdit', 'TYPE_2': 'TextEdit', 'ENGTYPE_2': 'TextEdit', 'NL_NAME_2': 'TextEdit', 'VARNAME_2': 'TextEdit', });
lyr_Bihar_AWSmasterdata_1.set('fieldImages', {'ClientID': 'TextEdit', 'District': 'TextEdit', 'Block': 'TextEdit', 'Location': 'TextEdit', 'Latitude': 'TextEdit', 'Longitude': 'TextEdit', 'Rain (mm)': 'TextEdit', 'Temperature( �C )': 'TextEdit', 'Humidity(%)': 'TextEdit', 'Wind Speed( m/sec )': 'TextEdit', 'Wind Direction( degrees)': 'TextEdit', 'Local Pressure( mb )': 'TextEdit', 'Solar Radiation': 'TextEdit', });
lyr_Bihar_State_0.set('fieldLabels', {'ID_0': 'no label', 'ISO': 'no label', 'NAME_0': 'no label', 'ID_1': 'no label', 'NAME_1': 'no label', 'ID_2': 'no label', 'NAME_2': 'no label', 'TYPE_2': 'no label', 'ENGTYPE_2': 'no label', 'NL_NAME_2': 'no label', 'VARNAME_2': 'no label', });
lyr_Bihar_AWSmasterdata_1.set('fieldLabels', {'ClientID': 'inline label', 'District': 'inline label', 'Block': 'inline label', 'Location': 'inline label', 'Latitude': 'inline label', 'Longitude': 'inline label', 'Rain (mm)': 'inline label', 'Temperature( �C )': 'inline label', 'Humidity(%)': 'inline label', 'Wind Speed( m/sec )': 'inline label', 'Wind Direction( degrees)': 'inline label', 'Local Pressure( mb )': 'inline label', 'Solar Radiation': 'inline label', });
lyr_Bihar_AWSmasterdata_1.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});