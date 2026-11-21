from users.models import Group

SUPERUSER_GROUP = "superusers"


def _claim_groups(response):
    groups = response.get("groups", [])
    if isinstance(groups, str):
        return {groups}
    return set(groups)


def sync_groups(response, user, backend, *args, **kwargs):
    groups = [
        Group.objects.get_or_create(name=group_name)[0]
        for group_name in sorted(_claim_groups(response))
    ]
    user.groups.set(groups)


def set_superuser(response, user, backend, *args, **kwargs):
    user.is_superuser = SUPERUSER_GROUP in _claim_groups(response)
    user.save(update_fields=["is_superuser"])
