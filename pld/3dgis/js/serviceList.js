var SERVICES = {
    DOP5K: '/iserver/services/3D-Phase2_Data/rest/realspace/datas/dop5k201555402_1@data',
	Base_Map: 'https://pld-gisweb.pland.hksarg/arcgis/rest/services/Basemap/BMS_COLOR_WM/MapServer',
	OZP_Zone: '/iserver/services/map-OZP_ZONE/rest/maps/OZP_ZONE_WGS84',
	SPOT_RGB: '/iserver/services/map-Imagery_Map/rest/maps/SPOT_RGB',
	SPOT_NIR: '/iserver/services/map-Imagery_Map/rest/maps/SPOT_NIR',
	Lot_Map: '/iserver/services/map-OZP_ZONE/rest/maps/Lot_WGS84',
	AAM_Model:'/iserver/services/3D-Phase2_Data/rest/realspace/datas/AAM_Model@model/config',
	bldg_wgs: '/iserver/services/3D-Phase2_Data/rest/realspace/datas/Bldg@model/config',
	podium_wgs: '/iserver/services/3D-Phase2_Data/rest/realspace/datas/Podium@model/config',
	PolyU: '/iserver/services/3D-PlanD_Phase1/rest/realspace/datas/Config/config',
	cyber_port: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/CyperPort_s3m/config',
	TaiKooShing: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/TaiKooShing_s3m/config',
	SaiKung: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/SaiKung_s3m/config',
	WanChai: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/WanChai/config',
	bldgLabel: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/Bldg_Label/config',
	BHCZ: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/rest1/config',
	QuarryBay: '/iserver/services/3D-OSGB_Trial/rest/realspace/datas/QuarryBay/config'
};

var SERVICES3D = {
	"DOP5K":{
		"LayerType": "Imagery3D",
		"Category": "BaseMap",
		"URL": "/iserver/services/3D-Phase2_Data/rest/realspace/datas/dop5k201555402_1@data"
	},
	"Base_Map":{
		"LayerType": "ArcGIS_REST",
		"Category": "BaseMap",
		"URL": "https://pld-gisweb.pland.hksarg/arcgis/rest/services/Basemap/BMS_COLOR_WM/MapServer"
	},
	"OZP_Zone":{
		"LayerType": "Imagery2D",
		"Category": "CPDH",
		"URL": "/iserver/services/map-OZP_ZONE/rest/maps/OZP_ZONE_WGS84"
	},
	"SPOT_RGB":{
		"LayerType": "Imagery2D",
		"Category": "BaseMap",
		"URL": "/iserver/services/map-Imagery_Map/rest/maps/SPOT_RGB"
	},
	"SPOT_NIR":{
		"LayerType": "Imagery2D",
		"Category": "BaseMap",
		"URL": "/iserver/services/map-Imagery_Map/rest/maps/SPOT_NIR"
	},
	"Land Lot":{
		"LayerType": "Imagery2D",
		"Category": "CPDH",
		"URL": "/iserver/services/map-OZP_ZONE/rest/maps/Lot_WGS84"
	},
	"Height Control":{
		"LayerType": "S3M",
		"Category": "CPDH",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/rest1/config"
	},
	"AAM_Model":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-Phase2_Data/rest/realspace/datas/AAM_Model@model/config"
	},
	"Building":{
		"LayerType": "S3M",
		"Category": "CPDH",
		"URL": "/iserver/services/3D-Phase2_Data/rest/realspace/datas/Bldg@model/config"
	},
	"Podium":{
		"LayerType": "S3M",
		"Category": "CPDH",
		"URL": "/iserver/services/3D-Phase2_Data/rest/realspace/datas/Podium@model/config"
	},
	"PolyU":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-PlanD_Phase1/rest/realspace/datas/Config/config"
	},
	"CyberPort":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/CyperPort_s3m/config"
	},
	"TaiKooShing":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/TaiKooShing_s3m/config"
	},
	"SaiKung":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/SaiKung_s3m/config"
	},
	"WanChai":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/WanChai/config"
	},
	"Hong_Kong_Island":{
		"LayerType": "S3M",
		"Category": "3DModel",
		"URL": "/iserver/services/3D-OSGB_Trial/rest/realspace/datas/HK_Island/config"
	}
}