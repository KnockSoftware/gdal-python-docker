Python with GDAL in a Docker image
===

This is a base image needed for many geographic extensions of Django.

Run `make manual-release` to generate a new Docker image and push it to ECR.

As of July 2019, this base image is used in:
 - `authservice` -- https://github.com/RideReport/authservice
 - `blackhole` -- https://github.com/RideReport/blackhole
 - `djscoots` -- https://github.com/RideReport/djscoots
 - `orchescooter` -- https://github.com/RideReport/orchescooter
 - `rideserver` -- https://github.com/RideReport/rideserver
 - `scootpower` -- https://github.com/RideReport/scootpower
