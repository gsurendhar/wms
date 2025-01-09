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
var format_Mandal_Boundary_2_0 = new ol.format.GeoJSON();
var features_Mandal_Boundary_2_0 = format_Mandal_Boundary_2_0.readFeatures(json_Mandal_Boundary_2_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Mandal_Boundary_2_0 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Mandal_Boundary_2_0.addFeatures(features_Mandal_Boundary_2_0);var lyr_Mandal_Boundary_2_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Mandal_Boundary_2_0, 
                style: style_Mandal_Boundary_2_0,
                title: '<img src="styles/legend/Mandal_Boundary_2_0.png" /> Mandal_Boundary_2'
            });var format_District_Boundary_1 = new ol.format.GeoJSON();
var features_District_Boundary_1 = format_District_Boundary_1.readFeatures(json_District_Boundary_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_District_Boundary_1 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_District_Boundary_1.addFeatures(features_District_Boundary_1);var lyr_District_Boundary_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_District_Boundary_1, 
                style: style_District_Boundary_1,
                title: '<img src="styles/legend/District_Boundary_1.png" /> District_Boundary'
            });var format_Bihar_AWSmasterdata_ARG_2 = new ol.format.GeoJSON();
var features_Bihar_AWSmasterdata_ARG_2 = format_Bihar_AWSmasterdata_ARG_2.readFeatures(json_Bihar_AWSmasterdata_ARG_2, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Bihar_AWSmasterdata_ARG_2 = new ol.source.Vector({
    attributions: [new ol.Attribution({html: '<a href=""></a>'})],
});
jsonSource_Bihar_AWSmasterdata_ARG_2.addFeatures(features_Bihar_AWSmasterdata_ARG_2);var lyr_Bihar_AWSmasterdata_ARG_2 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Bihar_AWSmasterdata_ARG_2, 
                style: style_Bihar_AWSmasterdata_ARG_2,
                title: '<img src="styles/legend/Bihar_AWSmasterdata_ARG_2.png" /> Bihar_AWS master data_ARG'
            });

lyr_Mandal_Boundary_2_0.setVisible(true);lyr_District_Boundary_1.setVisible(true);lyr_Bihar_AWSmasterdata_ARG_2.setVisible(true);
var layersList = [baseLayer,lyr_Mandal_Boundary_2_0,lyr_District_Boundary_1,lyr_Bihar_AWSmasterdata_ARG_2];
lyr_Mandal_Boundary_2_0.set('fieldAliases', {'OBJECTID': 'OBJECTID', 'BLK_C_2011': 'BLK_C_2011', 'Shape_Leng': 'Shape_Leng', 'Shape_Area': 'Shape_Area', 'Block_Name': 'Block_Name', 'Blk_Name': 'Blk_Name', });
lyr_District_Boundary_1.set('fieldAliases', {'OBJECTID': 'OBJECTID', 'DIST_CEN_C': 'DIST_CEN_C', 'Shape_Leng': 'Shape_Leng', 'Shape_Area': 'Shape_Area', 'Dist_Name': 'Dist_Name', });
lyr_Bihar_AWSmasterdata_ARG_2.set('fieldAliases', {'ClientID': 'ClientID', 'District': 'District', 'Block': 'Block', 'Location': 'Location', 'Date_Time': 'Date_Time', 'Latitude': 'Latitude', 'Longitude': 'Longitude', 'Rain (mm)': 'Rain (mm)', });
lyr_Mandal_Boundary_2_0.set('fieldImages', {'OBJECTID': 'TextEdit', 'BLK_C_2011': 'TextEdit', 'Shape_Leng': 'TextEdit', 'Shape_Area': 'TextEdit', 'Block_Name': 'TextEdit', 'Blk_Name': 'TextEdit', });
lyr_District_Boundary_1.set('fieldImages', {'OBJECTID': 'TextEdit', 'DIST_CEN_C': 'TextEdit', 'Shape_Leng': 'TextEdit', 'Shape_Area': 'TextEdit', 'Dist_Name': 'TextEdit', });
lyr_Bihar_AWSmasterdata_ARG_2.set('fieldImages', {'ClientID': 'TextEdit', 'District': 'TextEdit', 'Block': 'TextEdit', 'Location': 'TextEdit', 'Date_Time': 'TextEdit', 'Latitude': 'TextEdit', 'Longitude': 'TextEdit', 'Rain (mm)': 'TextEdit', });
lyr_Mandal_Boundary_2_0.set('fieldLabels', {'OBJECTID': 'no label', 'BLK_C_2011': 'no label', 'Shape_Leng': 'no label', 'Shape_Area': 'no label', 'Block_Name': 'no label', 'Blk_Name': 'no label', });
lyr_District_Boundary_1.set('fieldLabels', {'OBJECTID': 'no label', 'DIST_CEN_C': 'no label', 'Shape_Leng': 'no label', 'Shape_Area': 'no label', 'Dist_Name': 'no label', });
lyr_Bihar_AWSmasterdata_ARG_2.set('fieldLabels', {'ClientID': 'inline label', 'District': 'inline label', 'Block': 'inline label', 'Location': 'inline label', 'Date_Time': 'inline label', 'Latitude': 'inline label', 'Longitude': 'inline label', 'Rain (mm)': 'inline label', });
lyr_Bihar_AWSmasterdata_ARG_2.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});