class DockerController < ApplicationController
    before_action :set_container
    def run
        # Port 3001 is the port that the docker container will run on.
        # The network name is "rails"
        @container = Container.find(params[:container_id])

        port = @container.port.to_s

        container_name = @container.container_name

        if container_name
            docker_run = `docker start #{container_name}`
            redirect_back fallback_location: root_path, 
                notice: "Container #{container_name} is running on port #{port}"
        else
            docker_run = `docker run -d -p #{port}:3001 --network rails rails7`

            # Get the container ID from the output of the docker run command.
            container_id = docker_run.strip

            # Get the container name using the container ID.
            container_name = `docker inspect --format='{{.Name}}' #{container_id}`.strip

            # Remove the leading slash from the container name.
            container_name = container_name[1..-1] if container_name.start_with?('/')

            # Save the container name to the model.
            @container.update(container_name: container_name)
            redirect_back fallback_location: root_path, 
            notice: "Container #{container_name} is running on port #{port}"
        end
    end

    def stop
        container_name = @container.container_name
        `docker stop #{container_name}`

        redirect_back fallback_location: root_path,
        notice: "Container #{container_name} has been stopped"
    end

    private

    def set_container
        @container = Container.find(params[:container_id])
    end
end
