local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.swtimagej', 'eclipse-swtimagej') {
  settings+: {
    description: "",
    name: "Eclipse SWTImageJ",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('SWTImageJ') {
      default_branch: "develop",
      has_wiki: true,
    },
    orgs.newRepo('website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "The SWTimageJ website content",
      web_commit_signoff_required: false,
    },
  ],
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/swtimagej/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
