# Class: jirabackup
#
# This class installs and configures the atlassian-backup utility
#
# Parameters:
# 
#  db_host: (default '')
#  Set the postgres database host to connect to
#
#  db_pass: (default '')
#  Set the postgres database password
#
#  db_user: (default 'jira')
#  Set the postgres database user
#
#  db_name: (default 'jira')
#  Set the postgres database name
#
#  backup_dir: (default '/var/atlassian/backups/jira')
#  Set the target backup directory for Jira attachments and postgres dumps
#
#  attachments_path: (default '/var/atlassian/application-data/jira/data/attachments')
#  Set the path to the Jira attachments
#
#  app: (default 'jira')
#  Set the name of the Atlassian application
#
# Actions:
#  - Install atlassian-backup utility
#  - Manage the jira-backup configuration settings
#
# Requires:
#
# Sample Usage:
#
#   class { 'jirabackup':
#     db_host          => 'postgres.example.com',
#     db_pass          => 'database password',
#     db_user          => 'jira',
#     db_name          => 'jira',
#     backup_dir       => '/path/to/backup/output/dir',
#     attachments_path => '/path/to/jira/attachments',
#     app              => 'jira'
#   }
#
class jirabackup (
  $db_host,
  $db_pass,
  $db_user          = 'jira',
  $db_name          = 'jira',
  $backup_dir       = '/var/atlassian/backups/jira',
  $attachments_path = '/var/atlassian/application-data/jira/data/attachments',
  $app              = 'jira'
){
  file { '/usr/local/bin/atlassian-backup':
    ensure => present,
    group  => 'root',
    owner  => 'root',
    mode   => '0755',
    source => "puppet:///modules/atlassianbackup/atlassian-backup",
  }

  file { '/etc/jira-backup.conf':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('atlassianbackup/atlassian-backup.conf.erb'),
  }

  file { '/root/.pgpass':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('atlassianbackup/pgpass.erb'),
  }
}

# Class: confluencebackup
#
# This class installs and configures the jira-backup utility
#
# Parameters:
# 
#  db_host: (default '')
#  Set the postgres database host to connect to
#
#  db_pass: (default '')
#  Set the postgres database password
#
#  db_user: (default 'confluence')
#  Set the postgres database user
#
#  db_name: (default 'confluence')
#  Set the postgres database name
#
#  backup_dir: (default '/var/atlassian/backups/confluence')
#  Set the target backup directory for Jira attachments and postgres dumps
#
#  attachments_path: (default '/var/atlassian/application-data/confluence/data/attachments')
#  Set the path to the Jira attachments
#
#  app: (default 'confluence')
#  Set the name of the Atlassian application
#
# Actions:
#  - Install atlassian-backup utility
#  - Manage the confluence-backup configuration settings
#
# Requires:
#
# Sample Usage:
#
#   class { 'confluencebackup':
#     db_host          => 'postgres.example.com',
#     db_pass          => 'database password',
#     db_user          => 'confluence',
#     db_name          => 'confluence',
#     backup_dir       => '/path/to/backup/output/dir',
#     attachments_path => '/path/to/confluence/attachments',
#     app              => 'confluence'
#   }
#
class confluencebackup (
  $db_host,
  $db_pass,
  $db_user          = 'confluence',
  $db_name          = 'confluence',
  $backup_dir       = '/var/atlassian/backups/confluence',
  $attachments_path = '/var/atlassian/application-data/confluence/data/attachments',
  $app              = 'confluence'
){
  file { '/usr/local/bin/atlassian-backup':
    ensure => present,
    group  => 'root',
    owner  => 'root',
    mode   => '0755',
    source => "puppet:///modules/atlassianbackup/atlassian-backup",
  }

  file { '/etc/confluence-backup.conf':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('atlassianbackup/atlassian-backup.conf.erb'),
  }

  file { '/root/.pgpass':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0600',
    content => template('atlassianbackup/pgpass.erb'),
  }
}
