class BaseConfig(object):
    ENVIRONMENT = None
    
    # paths
    INSTANCE_FOLDER_PATH = "/instance"


class Development(BaseConfig):
    ENVIRONMENT = "development"


class Staging(BaseConfig):
    ENVIRONMENT = "staging"


class Production(BaseConfig):
    ENVIRONMENT = "production"
