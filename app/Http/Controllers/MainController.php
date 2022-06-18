<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request; 
use Redirect;
use DB;

class MainController extends Controller
{
   	public function index(){  

        return view('index');
    }

    public function show(Request $request){
        $input = $request->all();
        DB::select('CALL  sp_update_algorithm');
        $data = DB::select('CALL  sp_predict("'.$request->jk.'",'.$request->umur.','.$request->hipertensi.','.$request->penyakit_jantung.',"'.$request->menikah.'","'.$request->pekerjaan.'","'.$request->tinggal.'",'.$request->glukosa.','.$request->bmi.',"'.$request->merokok.'")');   
        return view('index',compact(
            [
                'data',
                'input'
            ]
        ));
    }
}
