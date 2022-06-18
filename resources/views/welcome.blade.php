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
                        <div class="row">
                             <div class="row col-sm-6">
                                <div class="col-sm-6">
                                    <label class="form-control">Jenis Kelamin</label>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="jk"  value="Male">
                                        </div>
                                      </div>
                                      <label class="form-control">Pria</label>
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="jk" value="Female">
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
                                       <input type="number" class="form-control" name="umur">
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
                                        <input type="radio" name="hipertensi"  value="1">
                                        </div>
                                      </div>
                                      <label class="form-control">Ya</label>
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="hipertensi" value="0">
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
                                        <input type="radio" name="penyakit_jantung"  value="1">
                                        </div>
                                      </div>
                                      <label class="form-control">Ya</label>
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="penyakit_jantung" value="0">
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
                                        <input type="radio" name="menikah"  value="Yes">
                                        </div>
                                      </div>
                                      <label class="form-control">Ya</label>
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="menikah" value="No">
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
                                      <select class="custom-select form-control" name="pekerjaan">
                                        <option selected>Choose...</option>
                                        <option value="children">Anak-Anak</option>
                                        <option value="Govt_job">Pekerjaan Pemerintah</option>
                                        <option value="Private">Pribadi</option>
                                        <option value="Self-employed">Karyawan</option>
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
                                        <input type="radio" name="tinggal" value="Urban">
                                        </div>
                                      </div>
                                      <label class="form-control">Perkotaan</label>
                                      <div class="input-group-prepend">
                                        <div class="input-group-text">
                                        <input type="radio" name="tinggal" value="Rural">
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
                                       <input type="number" class="form-control" name="glukosa">
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
                                       <input type="number" class="form-control" name="bmi">
                                    </div>
                                </div> 
                            </div> 

                            <div class="row col-sm-6">
                                <div class="col-sm-6">
                                    <label class="form-control">Apakah Anda merokok?</label>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                      <select class="custom-select form-control" name="pekerjaan">
                                        <option selected>Choose...</option>
                                        <option value="never smoked">Tidak pernah merokok</option>
                                        <option value="formerly smoked">Sebelumnya merokok</option>
                                        <option value="smoked">Merokok</option> 
                                      </select>
                                    </div>
                                </div> 
                            </div>

                             <div class="row col-sm-12">
                                <div class="col-sm-12">
                                    <button type="submit" class="btn btn-primary form-control" >Kirim</button>
                                </div> 
                            </div> 
                        </div> 
                    </div>
                    <div class="card-footer"> 
                        <h3>Hasil</h3>
                        Apakah saya mengalamin strok ? Ya<br>
                        Presentase Keyakinan
                        <div class="progress">
                          <div class="progress-bar" role="progressbar" aria-valuenow="99" aria-valuemin="0" aria-valuemax="100" style="width: 99%">
                              99%
                          </div>
                        </div>
                       

                    </div>
                </div> 
            </div> 
        </div>    
      </div>
    </body>
</html>
