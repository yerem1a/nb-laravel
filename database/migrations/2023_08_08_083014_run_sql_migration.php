<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RunSqlMigration extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $sqlPath = base_path('database/migrations/sql/'); // Path ke folder sql di dalam direktori database

        // Execute each SQL file in the folder
        $sqlFiles = ['v1.0-up.sql', 'v1.1-up.sql'];
        foreach ($sqlFiles as $sqlFile) {
            DB::unprepared(file_get_contents($sqlPath . $sqlFile));
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        $sqlPath = base_path('database/sql/');

        // Execute each SQL file in the reverse order
        $sqlFiles = ['v1.1-down.sql', 'v1.0-down.sql'];
        foreach ($sqlFiles as $sqlFile) {
            DB::unprepared(file_get_contents($sqlPath . $sqlFile));
        }
    }
}
