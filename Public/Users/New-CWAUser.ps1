# function New-CWAUser {
#     $Body = @{
#         Name         = ''
#         FirstName    = ''
#         LastName     = ''
#         EmailAddress = ''
#         Password     = ''
#         #'AssociatedGroups' = @{'Name' = '' }
#         #'UserClasses'      = @{'Name' = '' }
#         #'CommandLevel'     = 0
#         #'Folder'           = @{'Name' = '' }
#     }

#     $RequestParams = @{
#         Body     = $Body
#         Endpoint = ('/v1/Users')
#         Method   = 'Post'
#     }

#     Invoke-CWAAPI @RequestParams
# }
