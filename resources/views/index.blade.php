<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> 
        <title>Laravel</title>     
    </head>
    <body>
       <div class="row">
            <div class="container-fluid p-5">
                <div class="card">
                    <div class="card-header">
                        <h4>PREDIKSI STROKE BERBASIS METODE NAIVE BAYES CLASSIFICATION</h4>
                    </div>
                    <div class="card-body"> 
                        <form action="{{ url('/send') }}" method="post">
                             {{ csrf_field() }}
                            <div class="row">
                                 <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Jenis Kelamin</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="jk"  value="Male" @if(isset($input)) @if($input['jk'] == 'Male') checked @endif @endif required>
                                            </div>
                                          </div>
                                          <label class="form-control">Pria</label>
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="jk" value="Female" @if(isset($input)) @if($input['jk'] == 'Female') checked @endif @endif>
                                            </div>
                                          </div>
                                          <label class="form-control">Wanita</label>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                         <div class="input-group">
                                          <label class="form-control">Umur</label>  
                                        </div>
                                    </div> 
                                    <div class="col-sm-6">
                                         <div class="input-group"> 
                                           <input type="number" class="form-control" name="umur" value="@if(isset($input)){{$input['umur']}}@endif" required>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Apakah menderita hipertensi?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="hipertensi"  value="1" @if(isset($input)) @if($input['hipertensi'] == 1) checked @endif @endif required>
                                            </div>
                                          </div>
                                          <label class="form-control">Ya</label>
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="hipertensi" value="0" @if(isset($input)) @if($input['hipertensi'] == 0) checked @endif @endif>
                                            </div>
                                          </div>
                                          <label class="form-control">Tidak</label>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Apakah memiliki penyakit jantung?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="penyakit_jantung"  value="1" @if(isset($input)) @if($input['penyakit_jantung'] == 1) checked @endif @endif required>
                                            </div>
                                          </div>
                                          <label class="form-control">Ya</label>
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="penyakit_jantung" value="0"  @if(isset($input)) @if($input['penyakit_jantung'] == 0) checked @endif @endif>
                                            </div>
                                          </div>
                                          <label class="form-control">Tidak</label>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Apakah pernah menikah?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="menikah"  value="Yes" @if(isset($input)) @if($input['menikah'] == 'Yes') checked @endif @endif required>
                                            </div>
                                          </div>
                                          <label class="form-control">Ya</label>
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="menikah" value="No" @if(isset($input)) @if($input['menikah'] == 'No') checked @endif @endif>
                                            </div>
                                          </div>
                                          <label class="form-control">Tidak</label>
                                        </div>
                                    </div> 
                                </div> 

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Apa jenis pekerjaan Anda?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <select class="custom-select form-control" name="pekerjaan" required>
                                            <option value="" selected>Choose...</option>
                                            <option value="children"  @if(isset($input)) @if($input['pekerjaan'] == 'children') selected @endif @endif>Anak-Anak</option>
                                            <option value="Govt_job" @if(isset($input)) @if($input['pekerjaan'] == 'Govt_job') selected @endif @endif>Pekerjaan Pemerintah</option>
                                            <option value="Private" @if(isset($input)) @if($input['pekerjaan'] == 'Private') selected @endif @endif>Pribadi</option>
                                            <option value="Self-employed" @if(isset($input)) @if($input['pekerjaan'] == 'Self-employed') selected @endif @endif>Karyawan</option>
                                          </select>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Dimana kamu tinggal?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="tinggal" value="Urban" @if(isset($input)) @if($input['tinggal'] == 'Urban') checked @endif @endif required>
                                            </div>
                                          </div>
                                          <label class="form-control">Perkotaan</label>
                                          <div class="input-group-prepend">
                                            <div class="input-group-text">
                                            <input type="radio" name="tinggal" value="Rural" @if(isset($input)) @if($input['tinggal'] == 'Rural') checked @endif @endif>
                                            </div>
                                          </div>
                                          <label class="form-control">Pedesaan</label>
                                        </div>
                                    </div> 
                                </div>

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                         <div class="input-group">
                                          <label class="form-control">Berapa rata-rata kadar glukosa Anda?</label>  
                                        </div>
                                    </div> 
                                    <div class="col-sm-6">
                                         <div class="input-group"> 
                                           <input type="number" class="form-control" name="glukosa" value="@if(isset($input)){{$input['glukosa']}}@endif" step=".01" required>
                                        </div>
                                    </div> 
                                </div> 

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                         <div class="input-group">
                                          <label class="form-control">Berapa indeks massa tubuh Anda?</label>  
                                        </div>
                                    </div> 
                                    <div class="col-sm-6">
                                         <div class="input-group"> 
                                           <input type="number" class="form-control" name="bmi" value="@if(isset($input)){{$input['bmi']}}@endif" step=".01" required>
                                        </div>
                                    </div> 
                                </div> 

                                <div class="row col-sm-6">
                                    <div class="col-sm-6">
                                        <label class="form-control">Apakah Anda merokok?</label>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                          <select class="custom-select form-control" name="merokok" required>
                                            <option value=""  selected>Choose...</option>
                                            <option value="never smoked" @if(isset($input)) @if($input['merokok'] == 'never smoked') selected @endif @endif>Tidak pernah merokok</option> 
                                            <option value="formerly smoked"  @if(isset($input)) @if($input['merokok'] == 'formerly smoked') selected @endif @endif>Sebelumnya merokok</option>  
                                            <option value="smokes" @if(isset($input))  @if($input['merokok'] == 'smoked') selected @endif @endif>Merokok</option> 
                                          </select>
                                        </div>
                                    </div> 
                                </div>

                                 <div class="row col-sm-12">
                                    <div class="col-sm-6">
                                        <button type="submit" class="btn btn-primary form-control" >Kirim</button>
                                    </div> 
                                     <div class="col-sm-6">
                                        <a href="{{ url('/') }}" class="btn btn-danger form-control" >Reset</a>
                                    </div> 
                                </div> 
                            </div> 
                        </form>
                    </div>
                    <div class="card-footer"> 
                        @if(isset($data))
                            <h3>Hasil</h3>
                            Apakah saya mengalamin strok ? @if($data[0]->stroke == 1) Ya @else Tidak @endif<br>
                            Presentase Keyakinan
                            <div class="progress">
                              <div class="progress-bar bg-success" role="progressbar" aria-valuenow="@if($data[0]->stroke == 1) {{floor($data[0]->probability_stroke_1 * 100)}} @else {{floor($data[0]->probability_stroke_0 * 100)}} @endif" aria-valuemin="0" aria-valuemax="100" style="width: @if($data[0]->stroke == 1) {{floor($data[0]->probability_stroke_1 * 100)}}% @else {{floor($data[0]->probability_stroke_0 * 100)}}% @endif">
                                  @if($data[0]->stroke == 1) {{floor($data[0]->probability_stroke_1 * 100)}}% @else {{floor($data[0]->probability_stroke_0 * 100)}}% @endif 
                              </div>
                            </div> 
                        @endif 
                    </div>
                </div> 
            </div> 
        </div>    
      </div>
    </body>
</html>
