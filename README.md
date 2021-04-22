Python with GDAL in a Docker image
===

This is a base image needed for many geographic extensions of Django.

Run `make manual-release` to generate a new Docker image and push it to ECR.

As of April 2021, this base image is used in:
 - `authservice` -- https://github.com/RideReport/authservice
 - `blackhole` -- https://github.com/RideReport/blackhole
 - `custom-errors` -- https://github.com/RideReport/custom-errors
 - `djscoots` -- https://github.com/RideReport/djscoots
 - `mds_as_a_service` -- https://github.com/RideReport/mds_as_a_service
 - `orchescooter` -- https://github.com/RideReport/orchescooter
 - `scootpower` -- https://github.com/RideReport/scootpower

To open a PR in each of these repos with a new base image:
```bash
make manual-release
inv update-repos --base-tag=<tag-from-make-command>
```
