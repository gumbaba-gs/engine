[#ftl]
[@addMasterData
  provider=SHARED_PROVIDER
  data=
    {
      "Environments": {
        "alm": {
          "Id" : "alm",
          "Name" : "alm",
          "Title": "Application Lifecycle Management Environment",
          "Description": "Normally only one environment for the alm. Entry mainly here for naming consistency",
          "Category": "alm",
          "Operations": {
            "Expiration": 90
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "shared": {
          "Id" : "shared",
          "Name" : "shared",
          "Title": "Shared Services Environment",
          "Description": "One shared environment per account. Entry mainly here for naming consistency",
          "Category": "alm",
          "Operations": {
            "Expiration": 30
          }
        },
        "dev": {
          "Id" : "dev",
          "Name": "development",
          "Title": "Development Environment",
          "Description": "Potentially holds individual dev servers for multiple devs",
          "Category": "dev",
          "Operations": {
            "Expiration": 14
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "alpha": {
          "Id" : "alpha",
          "Name" : "alpha",
          "Title": "Alpha Environment",
          "Description": "Prototyping environment according to DTO classification",
          "Category": "test",
          "Operations": {
            "Expiration": 14
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "beta": {
          "Id" : "beta",
          "Name" : "beta",
          "Title": "Beta Environment",
          "Description": "Preproduction environment according to DTO classification",
          "Category": "stg",
          "MultiAZ": true,
          "Operations": {
            "Expiration": 90
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "int": {
          "Id" : "int",
          "Name": "integration",
          "Title": "Integration Environment",
          "Description": "Mainly for devs to confirm components work together",
          "Category": "test",
          "Operations": {
            "Expiration": 30
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "aat": {
          "Id" : "aat",
          "Name": "automatedacceptance",
          "Title": "Automated Acceptance Environment",
          "Description": "Execution of automated tests",
          "Category": "test",
          "Operations": {
            "Expiration": 30
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "uat": {
          "Id" : "uat",
          "Name": "useracceptance",
          "Title": "User Acceptance Environment",
          "Description": "Manual customer testing",
          "Category": "test",
          "Operations": {
            "Expiration": 30
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "system": {
          "Id" : "system",
          "Name" : "system",
          "Title": "System Test Environment",
          "Description": "Same as UAT",
          "Category": "test",
          "MultiAZ": true,
          "Operations": {
            "Expiration": 30
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "preprod": {
          "Id" : "preprod",
          "Name": "preproduction",
          "Title": "Preproduction Environment",
          "Description": "Deployment, performance, volume testing",
          "Category": "stg",
          "MultiAZ": true,
          "Operations": {
            "Expiration": 90
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "stg": {
          "Id" : "stg",
          "Name": "staging",
          "Title": "Staging Environment",
          "Description": "Deployment, performance, volume testing. Staging is used both as a specific environment and as a category of environments.",
          "Category": "stg",
          "MultiAZ": true,
          "Operations": {
            "Expiration": 90
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        },
        "prod": {
          "Id" : "prod",
          "Name": "production",
          "Title": "Production Environment",
          "Description": "Kind of obvious...",
          "Category": "prod",
          "MultiAZ": true,
          "Operations": {
            "Expiration": 365
          },
          "DomainBehaviours": {
            "Segment": "naked"
          }
        },
        "trn": {
          "Id" : "trn",
          "Name": "training",
          "Title": "Training Environment",
          "Description": "",
          "Category": "prod",
          "Operations": {
            "Expiration": 90
          },
          "DomainBehaviours": {
            "Segment": "segmentInHost"
          }
        }
      },
      "Categories": {
        "alm": {
          "Id" : "alm",
          "Name" : "alm",
          "Title": "Application Lifecycle Management Environments"
        },
        "account": {
          "Id" : "account",
          "Name" : "account",
          "Title": "Account Resources"
        },
        "dev": {
          "Id" : "dev",
          "Name": "development",
          "Title": "Development Environments"
        },
        "test": {
          "Id" : "test",
          "Name": "testing",
          "Title": "Testing Environments"
        },
        "stg": {
          "Id" : "stg",
          "Name": "staging",
          "Title": "Staging Environments"
        },
        "prod": {
          "Id" : "prod",
          "Name": "production",
          "Title": "Production Environments"
        }
      },
      "Tiers": {
        "web": {
          "Id" : "web",
          "Name" : "web",
          "Title": "Web Tier",
          "Description": "Supports HMI",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "api": {
          "Id" : "api",
          "Name" : "api",
          "Title": "API Tier",
          "Description": "Supports externally exposed APIs",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "msg": {
          "Id" : "msg",
          "Name": "messaging",
          "Title": "Messaging Tier",

          "Description": "Supports system-to-system based interactions/services",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "app": {
          "Id" : "app",
          "Name": "application",
          "Title": "Applications Tier",
          "Description": "Supports application logic execution",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "db": {
          "Id" : "db",
          "Name": "database",
          "Title": "Database Tier",
          "Description": "Supports long term storage of content and customer data",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "dir": {
          "Id" : "dir",
          "Name": "directories",
          "Title": "Directories Tier",
          "Description": "Supports directories or domain controllers",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "ana": {
          "Id" : "ana",
          "Name": "analytics",
          "Title": "Analytics Tier",
          "Description": "Suports things like search engines",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "elb": {
          "Id" : "elb",
          "Name" : "elb",
          "Title": "External Load Balancer Tier",
          "Description": "Publically accessible application load balancers",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable": "external",
            "NetworkACL" : "open"
          }
        },
        "ilb": {
          "Id" : "ilb",
          "Name" : "ilb",
          "Title": "Internal Load Balancer Tier",
          "Description": "Internally accessible application load balancers",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable" : "internal",
            "NetworkACL" : "open"
          }
        },
        "mgmt": {
          "Id" : "mgmt",
          "Name": "management",
          "Title": "Management Tier",
          "Description": "Supports ssh based host access and internet access for internal hosts",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Instance" : "",
              "Version" : ""
            },
            "RouteTable": "external",
            "NetworkACL" : "open"
          }
        },
        "shared": {
          "Id" : "shared",
          "Name" : "shared",
          "Title": "Shared Tier",
          "Description": "Shared Tier",
          "Network": {
            "Enabled": true,
            "Link" : {
              "Tier" : "mgmt",
              "Component" : "vpc",
              "Version" : "",
              "Instance" : ""
            },
            "RouteTable": "external",
            "NetworkACL" : "open"
          }
        },
        "docs": {
          "Id" : "docs",
          "Name": "documentation",
          "Title": "Docs Tier",
          "Description": "Non-network Tier For documentation generation",
          "Network" : {
            "Enabled" : false
          }
        },
        "gbl": {
          "Id" : "global",
          "Name": "global",
          "Title": "Global Tier",
          "Description": "Components which are used for Global Services",
          "Network": {
            "Enabled": false
          }
        }
      },
      "Ports": {
        "couchdb": {
          "Port": 5984,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "ednp": {
          "Port": 25672,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "elasticsearch": {
          "Port": 9200,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "epmd": {
          "Port": 4369,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "http": {
          "Port": 80,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "httpalt": {
          "Port": 8080,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "httpredirect": {
          "Port": 80,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "2",
            "UnhealthyThreshold": "3",
            "Interval": "30",
            "Timeout": "5",
            "SuccessCodes": "301"
          }
        },
        "https": {
          "Port": 443,
          "Protocol": "HTTPS",
          "IPProtocol": "tcp",
          "Certificate": true,
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "kibana": {
          "Port": 5601,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "memcached": {
          "Port": 11211,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "meteor": {
          "Port": 3000,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "mongodb": {
          "Port": 27017,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "mysql": {
          "Port": 3306,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "node": {
          "Port": 9000,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "play": {
          "Port": 9000,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "playws": {
          "Port": 9000,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Protocol": "HTTP",
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "postgresql": {
          "Port": 5432,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "rabbit": {
          "Port": 5672,
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "rabbit-ui": {
          "Port": 15672,
          "Protocol": "HTTP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "2",
            "UnhealthyThreshold": "3",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "redis": {
          "Port": 6379,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "smtp": {
          "Port": 25,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "hsmtp": {
          "Port": 2025,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "ssh": {
          "Port": 22,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "ws": {
          "Port": 80,
          "Protocol": "TCP",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "wss": {
          "Port": 443,
          "Protocol": "SSL",
          "IPProtocol": "tcp",
          "HealthCheck": {
            "Path": "/",
            "HealthyThreshold": "3",
            "UnhealthyThreshold": "5",
            "Interval": "30",
            "Timeout": "5"
          }
        },
        "ephemeraltcp" : {
          "PortRange" : {
            "From" : 1024,
            "To" : 65535
          },
          "IPProtocol" : "tcp"
        },
        "ephemeraludp" : {
          "PortRange" : {
            "From" : 1024,
            "To" : 65535
          },
          "IPProtocol" : "udp"
        },
        "any" : {
          "PortRange" : {
            "From" : 0,
            "To" : 65535
          },
          "IPProtocol" : "all"
        },
        "anyudp" : {
          "PortRange" : {
            "From" : 0,
            "To" : 65535
          },
          "IPProtocol" : "udp"
        },
        "anytcp" : {
          "PortRange" : {
            "From" : 0,
            "To" : 65535
          },
          "IPProtocol" : "tcp"
        },
        "anyicmp" : {
          "IPProtocol" : "icmp",
          "ICMP" : {
            "Code" : -1,
            "Type" : -1
          }
        }
      },
      "PortMappings": {
        "couchdb": {
          "Source": "https",
          "Destination": "couchdb"
        },
        "elasticsearch": {
          "Source": "https",
          "Destination": "elasticsearch"
        },
        "http": {
          "Source": "http",
          "Destination": "http"
        },
        "httpalt": {
          "Source": "http",
          "Destination": "httpalt"
        },
        "httpredirect": {
          "Source": "http",
          "Destination": "httpredirect"
        },
        "https": {
          "Source": "https",
          "Destination": "http"
        },
        "httpsalt": {
          "Source": "https",
          "Destination": "httpalt"
        },
        "kibana": {
          "Source": "https",
          "Destination": "kibana"
        },
        "meteor": {
          "Source": "https",
          "Destination": "meteor"
        },
        "node": {
          "Source": "https",
          "Destination": "node"
        },
        "play": {
          "Source": "https",
          "Destination": "play"
        },
        "playwss": {
          "Source": "wss",
          "Destination": "playws"
        },
        "smtp": {
          "Source": "smtp",
          "Destination": "smtp"
        },
        "hsmtp": {
          "Source": "smtp",
          "Destination": "hsmtp"
        },
        "ws": {
          "Source": "ws",
          "Destination": "ws"
        },
        "wss": {
          "Source": "wss",
          "Destination": "ws"
        }
      },
      "LogFiles": {
        "/var/log/dmesg": {
          "FilePath": "/var/log/dmesg"
        },
        "/var/log/messages": {
          "FilePath": "/var/log/messages",
          "TimeFormat": "%b %d %H:%M:%S"
        },
        "/var/log/secure": {
          "FilePath": "/var/log/secure",
          "TimeFormat": "%b %d %H:%M:%S"
        },
        "/var/log/cron": {
          "FilePath": "/var/log/cron",
          "TimeFormat": "%b %d %H:%M:%S"
        },
        "/var/log/audit/audit.log": {
          "FilePath": "/var/log/audit/audit.log",
          "MultiLinePattern": "^type"
        },
        "/var/log/aide/aide.log": {
          "FilePath": "/var/log/aide/aide.log",
          "TimeFormat": "%b %d %H:%M:%S"
        },
        "/var/log/docker": {
          "FilePath": "/var/log/docker",
          "TimeFormat": "%b %d %H:%M:%S"
        }
      },
      "LogFileGroups": {
        "security": {
          "LogFiles": [
            "/var/log/secure",
            "/var/log/audit/audit.log",
            "/var/log/aide/aide.log"
          ]
        },
        "system": {
          "LogFiles": [
            "/var/log/dmesg",
            "/var/log/messages",
            "/var/log/cron"
          ]
        },
        "docker": {
          "LogFiles": [
            "/var/log/docker"
          ]
        }
      },
      "CORSProfiles": {
        "S3Read": {
          "AllowedOrigins": [
            "*"
          ],
          "AllowedMethods": [
            "GET",
            "HEAD"
          ],
          "AllowedHeaders": [
            "*"
          ],
          "ExposedHeaders": [
            "ETag"
          ],
          "MaxAge": 1800
        },
        "S3Write": {
          "AllowedOrigins": [
            "*"
          ],
          "AllowedMethods": [
            "PUT",
            "POST"
          ],
          "AllowedHeaders": [
            "Content-Length",
            "Content-Type",
            "Content-MD5",
            "Authorization",
            "Expect"
          ],
          "ExposedHeaders": [
            "ETag"
          ],
          "MaxAge": 1800
        },
        "S3Delete": {
          "AllowedOrigins": [
            "*"
          ],
          "AllowedMethods": [
            "DELETE"
          ],
          "AllowedHeaders": [
            "Content-Length",
            "Content-Type",
            "Content-MD5",
            "Authorization",
            "Expect"          ],
          "ExposedHeaders": [
            "ETag"
          ],
          "MaxAge": 1800
        }
      },
      "ScriptStores": {
        "_startup": {
          "Engine": "local",
          "Source": {
            "Directory": "$\\{GENERATION_STARTUP_DIR}/bootstrap"
          },
          "Destination": {
            "Prefix": "bootstrap"
          }
        }
      },
      "Bootstraps": {},
      "LogFilters": {
        "_all": {
          "Pattern": ""
        },
        "_pylog-critical": {
          "Pattern": "CRITICAL"
        },
        "_pylog-error": {
          "Pattern": "?CRITICAL ?ERROR"
        },
        "_pylog-warning": {
          "Pattern": "?CRITICAL ?ERROR ?WARNING"
        },
        "_pylog-info": {
          "Pattern": "?CRITICAL ?ERROR ?WARNING ?INFO"
        },
        "_pylog-debug": {
          "Pattern": "?CRITICAL ?ERROR ?WARNING ?INFO ?DEBUG"
        },
        "apache": {
          "Pattern": "[ip, id, user, timestamp, request, status_code=*, size]"
        },
        "_apache-4xx": {
          "Pattern": "[ip, id, user, timestamp, request, status_code=4*, size]"
        },
        "_apache-5xx": {
          "Pattern": "[ip, id, user, timestamp, request, status_code=5*, size]"
        }
      },
      "AlertRules" : {
        "All" : {
          "Severity" : "info",
          "Destinations" : {
            "Links" : {}
          }
        }
      },
      "AlertProfiles" : {
        "default" : {
          "Rules" : [ "All" ]
        }
      }
    }
/]