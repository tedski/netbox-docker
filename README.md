# netbox-docker

Custom NetBox container image with plugins, published to
`ghcr.io/tedski/netbox:latest`.

Derived from [netbox-community/netbox-docker](https://github.com/netbox-community/netbox-docker)
(Apache 2.0).

## Plugins

- [netbox-topology-views](https://github.com/netbox-community/netbox-topology-views)

## Build

```bash
gh workflow run 'build and push'
# or push to main
```

## License

Apache License 2.0. See [LICENSE](LICENSE).
