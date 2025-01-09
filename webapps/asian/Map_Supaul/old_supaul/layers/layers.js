var wms_layers = [];
var baseLayer = new ol.layer.Group({
    'title': '',
    layers: [
new ol.layer.Tile({
    'title': 'OSM',
    'type': 'base',
    source: new ol.source.OSM()
})
]
});
var format_Suapul_0 = new ol.format.GeoJSON();
var features_Suapul_0 = format_Suapul_0.readFeatures(json_Suapul_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Suapul_0 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Suapul_0.addFeatures(features_Suapul_0);var lyr_Suapul_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Suapul_0, 
                style: style_Suapul_0,
                title: '<img src="styles/legend/Suapul_0.png" /> Suapul'
            });var format_Suapul_Mandal_Boundary_1 = new ol.format.GeoJSON();
var features_Suapul_Mandal_Boundary_1 = format_Suapul_Mandal_Boundary_1.readFeatures(json_Suapul_Mandal_Boundary_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Suapul_Mandal_Boundary_1 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Suapul_Mandal_Boundary_1.addFeatures(features_Suapul_Mandal_Boundary_1);var lyr_Suapul_Mandal_Boundary_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Suapul_Mandal_Boundary_1, 
                style: style_Suapul_Mandal_Boundary_1,
                title: '<img src="styles/legend/Suapul_Mandal_Boundary_1.png" /> Suapul_Mandal_Boundary'
            });var format_Bihar_AWSmasterdata_Suapul_2 = new ol.format.GeoJSON();
var features_Bihar_AWSmasterdata_Suapul_2 = format_Bihar_AWSmasterdata_Suapul_2.readFeatures(json_Bihar_AWSmasterdata_Suapul_2, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Bihar_AWSmasterdata_Suapul_2 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Bihar_AWSmasterdata_Suapul_2.addFeatures(features_Bihar_AWSmasterdata_Suapul_2);var lyr_Bihar_AWSmasterdata_Suapul_2 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Bihar_AWSmasterdata_Suapul_2, 
                style: style_Bihar_AWSmasterdata_Suapul_2,
    title: 'Bihar_AWS master data_Suapul<br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_0.png" />  0.0000 - 29.2083 <br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_1.png" />  29.2083 - 58.4167 <br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_2.png" />  58.4167 - 87.6250 <br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_3.png" />  87.6250 - 116.8333 <br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_4.png" />  116.8333 - 146.0417 <br />\
    <img src="styles/legend/Bihar_AWSmasterdata_Suapul_2_5.png" />  146.0417 - 175.2500 <br />'
        });

lyr_Suapul_0.setVisible(true);lyr_Suapul_Mandal_Boundary_1.setVisible(true);lyr_Bihar_AWSmasterdata_Suapul_2.setVisible(true);
var layersList = [baseLayer,lyr_Suapul_0,lyr_Suapul_Mandal_Boundary_1,lyr_Bihar_AWSmasterdata_Suapul_2];
lyr_Suapul_0.set('fieldAliases', {'OBJECTID': 'OBJECTID', 'DIST_CEN_C': 'DIST_CEN_C', 'Shape_Leng': 'Shape_Leng', 'Shape_Area': 'Shape_Area', 'Dist_Name': 'Dist_Name', });
lyr_Suapul_Mandal_Boundary_1.set('fieldAliases', {'OBJECTID': 'OBJECTID', 'BLK_C_2011': 'BLK_C_2011', 'Shape_Leng': 'Shape_Leng', 'Shape_Area': 'Shape_Area', 'OBJECTID_1': 'OBJECTID_1', 'BLK_C_2012': 'BLK_C_2012', 'Shape_Le_1': 'Shape_Le_1', 'Shape_Ar_1': 'Shape_Ar_1', 'Blk_Name': 'Blk_Name', 'Dist_Name': 'Dist_Name', });
lyr_Bihar_AWSmasterdata_Suapul_2.set('fieldAliases', {'ClientID': 'ClientID', 'District': 'District', 'Block': 'Block', 'Location': 'Location', 'Date_Time': 'Date_Time', 'Latitude': 'Latitude', 'Longitude': 'Longitude', 'Rain (mm)': 'Rain (mm)', });
lyr_Suapul_0.set('fieldImages', {'OBJECTID': 'TextEdit', 'DIST_CEN_C': 'TextEdit', 'Shape_Leng': 'TextEdit', 'Shape_Area': 'TextEdit', 'Dist_Name': 'TextEdit', });
lyr_Suapul_Mandal_Boundary_1.set('fieldImages', {'OBJECTID': 'TextEdit', 'BLK_C_2011': 'TextEdit', 'Shape_Leng': 'TextEdit', 'Shape_Area': 'TextEdit', 'OBJECTID_1': 'TextEdit', 'BLK_C_2012': 'TextEdit', 'Shape_Le_1': 'TextEdit', 'Shape_Ar_1': 'TextEdit', 'Blk_Name': 'TextEdit', 'Dist_Name': 'TextEdit', });
lyr_Bihar_AWSmasterdata_Suapul_2.set('fieldImages', {'ClientID': 'TextEdit', 'District': 'TextEdit', 'Block': 'TextEdit', 'Location': 'TextEdit', 'Date_Time': 'TextEdit', 'Latitude': 'TextEdit', 'Longitude': 'TextEdit', 'Rain (mm)': 'TextEdit', });
lyr_Suapul_0.set('fieldLabels', {'OBJECTID': 'no label', 'DIST_CEN_C': 'no label', 'Shape_Leng': 'no label', 'Shape_Area': 'no label', 'Dist_Name': 'no label', });
lyr_Suapul_Mandal_Boundary_1.set('fieldLabels', {'OBJECTID': 'no label', 'BLK_C_2011': 'no label', 'Shape_Leng': 'no label', 'Shape_Area': 'no label', 'OBJECTID_1': 'no label', 'BLK_C_2012': 'no label', 'Shape_Le_1': 'no label', 'Shape_Ar_1': 'no label', 'Blk_Name': 'no label', 'Dist_Name': 'no label', });
lyr_Bihar_AWSmasterdata_Suapul_2.set('fieldLabels', {'ClientID': 'inline label', 'District': 'inline label', 'Block': 'inline label', 'Location': 'inline label', 'Date_Time': 'inline label', 'Latitude': 'inline label', 'Longitude': 'inline label', 'Rain (mm)': 'inline label', });
lyr_Bihar_AWSmasterdata_Suapul_2.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});