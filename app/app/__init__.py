import flask


def create_app(env):

    # create app
    app = flask.Flask(__name__, instance_path="/instance")

    # set config from object
    config_object = "app.config.{}".format(env.title())
    app.config.from_object(config_object)
    
    # set config from instance file
    instance_file_path = "{}/{}.py".format(app.config["INSTANCE_FOLDER_PATH"], env)
    app.config.from_pyfile(instance_file_path)



    # register test route
    @app.route("/")
    def default():
        return app.config["ENVIRONMENT"]

    return app
