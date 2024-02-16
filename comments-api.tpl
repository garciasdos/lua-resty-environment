{% if status == 400 then %}
{
"type": "https://api.postman.com/problems/bad-request",
"title": "Malformed request",
"status": 400,
"detail": "{{body.error.message}}"
}
{% elseif status == 403 then %}
{
"type": "https://api.postman.com/problems/forbidden",
"title": "Forbidden",
"status": 403,
"detail": "{{body.error.message}}"
}
{% elseif status == 404 then %}
{
"type": "https://api.postman.com/problems/not-found",
"title": "Not found",
"status": 404,
"detail": "{{body.error.message}}"
}
}
{% elseif status == 500 then %}
{
"type": "https://api.postman.com/problems/internal-server-error",
"title": "Something went wrong",
"status": 500,
"detail": "Something went wrong"
}
{% elseif body.comment then %}
{
"data": {
"id": {{body.comment.id}},
"createdBy": {{body.comment.createdBy}},
"createdAt": "{{body.comment.createdAt}}",
"updatedAt": "{{body.comment.updatedAt}}",
"body": "{{body.comment.body}}"
}
}
{% else %}
{
"data": [
{% for i, comment in ipairs(body.comments) do %}
{
"id": {{comment.id}},
"createdBy": {{comment.createdBy}},
"createdAt": "{{comment.createdAt}}",
"updatedAt": "{{comment.updatedAt}}",
"body": "{{comment.body}}"
}
{%      if i < #body.comments then %},
{%      end %}
{% end %}
]
}
{% end %}
