[include:'/dbm/_resources/migratorStartup.lgc']

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Migrations for [$migrator->'dbName']</title>
<link rel="stylesheet" type="text/css" href="/dbm/_resources/styles.css" />
</head>
<body>

<?lassoscript

	'<hr>';
	'<p><a href="migrator.lasso?migrateTo=N"><img src="/dbm/_resources/btn_migrateTo.gif" alt="" width="120" height="20" border="0" /></a>&nbsp;';
	'<a href="migrator.lasso?getVersion"><img src="/dbm/_resources/btn_getVersion.gif" alt="" width="120" height="20" border="0" /></a>&nbsp;';
	'<a href="migrator.lasso?printSchema"><img src="/dbm/_resources/btn_printSchema.gif" alt="" width="120" height="20" border="0" /></a></p>';
	'<hr>';

if: client_getParams >> 'getVersion';

	'<h2>Database '; $migrator->'dbName'; ' v.'; $migrator->'currentVersion'; '</h2> \r';

else: client_getParams >> 'printSchema';

	'<h2>Database '; $migrator->'dbName'; ' v.'; $migrator->'currentVersion'; '</h2> \r';

	iterate: $migrator->getTableNames, $thisTable;
		$tableSchemaData = (tableSchema: $migrator->'dbName');
		$tableSchemaData->(getSchemaFor: $thisTable);
		$tableSchemas->(insert:$tableSchemaData);
		include:'/dbm/_resources/schemaView.dsp';
	/iterate;

else: !(action_params->find:'migrateTo') || ((action_params->find:'migrateTo')->last)->second == 0;

	'<h2>L-Migrator</h2>';
	'<p>Please specify a target migration version number in the URL</p>';
	'<p>migrator.lasso?migrateTo=N</p>';
	'<p>Where N is currently a value from '; $migrator->'firstMigration'; ' to '; $migrator->'lastMigration'; '</p><p>';
	loop: -from=($migrator->'firstMigration'), -to = ($migrator->'lastMigration');
	($migrator->'currentVersion') == loop_count ?
	'Migrate to '  loop_count '<br />'
	| '<strong><a href="migrator.lasso?migrateTo=' loop_count '">Migrate to '  loop_count '</a></strong><br />' ;
	/loop;
	'</p><p>Current version is '; $migrator->'currentVersion'; '</p>';

else;

	$runResult = $migrator->(run: -migrateTo=((action_params->find:'migrateTo')->last)->second);

	if: $runResult;
		'<h2>'; $runResult; '</h2>';
		'<p>Use a value from '; $migrator->'firstMigration'; ' to '; $migrator->'lastMigration'; '</p>';
		'<p>Current version is '; $migrator->'currentVersion'; '</p>';
	else;
		'<h2>Migrated from '; $migrator->'currentVersion'; ' to '; $migrator->'migrateToVersion'; '</h2>';
		$migrator->showQueryStatements;
	/if;
/if;
?>


<p>
[iterate: $message, local('oneMessage');]
<br />[loop_count ]. -> [ $oneMessage]
[/iterate;]
</p>
</body>
</html>