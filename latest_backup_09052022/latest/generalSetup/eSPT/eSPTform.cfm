<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script>
	$(document).ready(function(){
		$(document).on('change','select',function(){
			
			if($('#kodePajak').val() == 'a') {
				$(".kodeTransaksi_one").show();	
				$(".kodeTransaksi_two").hide();	
				$(".kodeDokumen_one").show();
				$(".kodeDokumen_two").hide();
				
				if($('#kodeTransaksi').val() == '1') {
					$(".kodeStatus_one").show();
					$(".kodeStatus_two").hide();
					$(".kodeStatus_three").hide();
					$(".kodeStatus_four").hide();

				}else if($('#kodeTransaksi').val() == '2'){
					$(".kodeStatus_one").hide();
					$(".kodeStatus_two").show();
					$(".kodeStatus_three").hide();
					$(".kodeStatus_four").hide();
				}
			}else if($('#kodePajak').val() == 'b'){
				$(".kodeTransaksi_one").hide();
				$(".kodeTransaksi_two").show();
				$(".kodeDokumen_one").hide();
				$(".kodeDokumen_two").show();
				
				if($('#kodeTransaksi').val() == '1') {
					$(".kodeStatus_one").hide();
					$(".kodeStatus_two").hide();
					$(".kodeStatus_three").show();
					$(".kodeStatus_four").hide();
					
				}else if($('#kodeTransaksi').val() == '2'){
					$(".kodeStatus_one").hide();
					$(".kodeStatus_two").hide();
					$(".kodeStatus_three").hide();
					$(".kodeStatus_four").show();
				}
			}
		});
	});
</script>
<div class="container">
    <div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModal" aria-hidden="true">
        <div style="width:90%; margin:0 auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close closeFormModal" aria-hidden="true">&times;</button>
                    <h4 id="formModalTitle" class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" style="margin-left:-200px;">
                        <!--- NO 1 --->
                        
                        <div style="display:none">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <p id="refno" class="form-control-static"></p>
                            </div>
                            <div class="col-sm-2">
                                <p id="type" class="form-control-static"></p>
                            </div>
                        </div>
                        </div>
                        <div class="form-group">
                            <label id="kodePajakLabel" class="col-sm-4 control-label">Kode Pajak </label>
                            <div class="col-sm-8">
                                <select id="kodePajak" name="kodePajak">
                                  <option value="a">Pajak Keluaran</option>
                                  <option value="b">Pajak Masukan</option>
                                </select>
                            </div>
                        </div>
                        <!--- NO 2 --->
                        <!---IF (1)A : Pajak Keluaran --->
                        <div class="kodeTransaksi_one" style="display:inline">
                            <div class="form-group">
                                <label id="kodeTransaksiLabel" class="col-sm-4 control-label">Kode Transaksi</label>
                                <div class="col-sm-8">
                                    <select id="kodeTransaksi" name="kodeTransaksi">
                                      <option value="1">Ekspor</option>
                                      <option value="2">Penyerahan Dalam Negeri Dengan Faktur Pajak</option>
                                    </select>
                                </div>
                            </div> 
                        </div>
                        <!---IF (1)B : Pajak Masukan --->
                        <div class="kodeTransaksi_two" style="display:none">
                            <div class="form-group">
                                <label id="kodeTransaksiLabel" class="col-sm-4 control-label">Kode Transaksi</label>
                                <div class="col-sm-8" id="selectDropDown">
                                    <select id="kodeTransaksi" name="kodeTransaksi">
                                      <option value="1">Impor BKP dan Pemanfaatan BKP Tidak Berwujud dari Luar Daerah Pabean serta Pemanfaatan JKP dari Luar Daerah Pabean</option>
                                      <option value="2">Perolehan BKP/JKP Dalam Negeri</option>
                                      <option value="3">Pajak Masukan yang tidak dapat dikreditkan dan/atau Pajakan Masukan dan PPn BM yang atas Impor atau Perolehannya mendapat Fasilitas</option>
                                    </select>
                                </div>
                            </div> 
                        </div>
                        <!--- NO 3 --->
                        <!---IF (1)A-(2)1 : Pajak Keluaran --->
                        <div class="kodeStatus_one" style="display:inline">
                            <div class="form-group">
                                <label id="kodeStatusLabel" class="col-sm-4 control-label">Kode Status</label>
                                <div class="col-sm-8">
                                    <select id="kodeStatus">
                                      <option value="1">Ekspor BKP Berwujud</option>
                                      <option value="2">Ekspor BKP Tidak Berwujud</option>
                                      <option value="3">Ekspor JKP</option>
                                    </select>
                                </div>
                            </div> 
                        </div>
                        <!---IF (1)A-(2)2 : Pajak Keluaran --->
                        <div class="kodeStatus_two" style="display:none">
                            <div class="form-group">
                                <label id="kodeStatusLabel" class="col-sm-4 control-label">Kode Status</label>
                                <div class="col-sm-8">
                                    <select id="kodeStatus" name="kodeStatus">
                                      <option value="1">Kepada Pihak yang Bukan Pemungut PPN</option>
                                      <option value="2">Kepada Pemungut Bendaharawan</option>
                                      <option value="3">Kepada PEmungut Selain Bendaharawan</option>
                                      <option value="4">DPP Nilai Lain</option>
                                      <option value="6">Penyerahan Lainnya, termasuk penyerahan kepada turis asing dalam rangka VAT refund</option>
                                      <option value="7">Penyerahan yang PPN-nya Tidak Dipungut</option>
                                      <option value="8">Penyerahan yang PPN-nya Dibebaskan </option>
                                      <option value="9">Penyerahan Aktiva (Pasal 16D UU PPN)</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!---IF (1)B-(2)1 : Pajak Masukan --->
                        <div class="kodeStatus_three" style="display:none">
                            <div class="form-group">
                                <label id="kodeStatusLabel" class="col-sm-4 control-label">Kode Status</label>
                                <div class="col-sm-8">
                                    <select id='kodeStatus'>
                                      <option value="1">Impor BKP</option>
                                      <option value="2">Pemanfaatan BKP Tidak Berwujud dari luar Daerah Pabean</option>
                                      <option value="3">Pemanfaatan JKP daru luar Daerah Pabean</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!---IF (1)B-(2)2 and (1)B-(2)3 : Pajak Masukan --->
                        <div class="kodeStatus_four" style="display:none">
                            <div class="form-group">
                                <label id="kodeStatusLabel" class="col-sm-4 control-label">Kode Status</label>
                                <div class="col-sm-8">
                                    <select id='kodeStatus'>
                                      <option value="1">Kepada Pihak yang Bukan Pemungut PPN</option>
                                      <option value="2">Kepada Pemungut Bendaharawan</option>  <!--- Only for (1)B-2(3) --->
                                      <option value="3">Kepada PEmungut Selain Bendaharawan</option>
                                      <option value="4">DPP Nilai Lain</option>
                                      <option value="6">Penyerahan Lainnya, termasuk penyerahan kepada turis asing dalam rangka VAT refund</option>
                                      <option value="7">Penyerahan yang PPN-nya Tidak Dipungut</option> <!--- Only for (1)B-2(3) --->
                                      <option value="8">Penyerahan yang PPN-nya Dibebaskan </option> <!--- Only for (1)B-2(3) --->
                                      <option value="9">Penyerahan Aktiva (Pasal 16D UU PPN)</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--- NO 4 --->
                        <!---IF (1)A : Pajak Keluaran --->
                        <div class="kodeDokumen_one" style="display:inline">
                            <div class="form-group">
                                <label id="kodeDokumenLabel" class="col-sm-4 control-label">Kode Dokumen</label>
                                <div class="col-sm-8">
                                    <select id='kodeDokumen'>
                                      <option value="1">Faktur Pajak</option>
                                      <option value="2">Nota Retur / Nota Pembatalan</option>
                                      <option value="3">Dokumen yang Dipersamakan Dengan Faktur Pajak</option>
                                      <option value="4">Faktur Batal</option>
                                      <option value="5">Faktur Pajak Pengganti</option>
                                      <option value="6">Dokumen Ekspor (PEB)</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!---IF (1)B : Pajak Masukan --->
                        <div class="kodeDokumen_two" style="display:none">
                            <div class="form-group">
                                <label id="kodeDokumenLabel" class="col-sm-4 control-label">Kode Dokumen</label>
                                <div class="col-sm-8">
                                    <select id='kodeDokumen'>
                                      <option value="1">Faktur Pajak</option>
                                      <option value="2">PIB dan SSP</option>
                                      <option value="3">Surat Setoran Pajak</option>
                                      <option value="4">Nota Retur / Nota Pembatalan</option>
                                      <option value="5">Dokumen yang Dipersamakan Dengan Faktur Pajak</option>
                                      <option value="6">Faktur Batal</option>
                                      <option value="7">Faktur Pajak Pengganti</option>
                                      <option value="8">PIB</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--- NO 5 --->
                        <div class="form-group">
                            <label id="flagVATLabel" class="col-sm-4 control-label">Flag VAT</label>
                            <div class="col-sm-8">
                                <select id='flagVAT'>
                                  <option value="0">Bukan Penyerahan Lainnya kepada Turis Asing</option>
                                  <option value="1">Penyerahan Lainnya kepada Turis Asing</option>
                                </select>
                            </div>
                        </div> 
                        <!--- NO 6 --->
                        <div class="form-group">
                            <label id="npwpLabel" class="col-sm-4 control-label">NPWP</label>
                            <div class="col-sm-8">
                                <input type="text" id="NPWP" name="NPWP" maxlength="255"/>    
                            </div>
                        </div>
                        <!--- NO 7 --->
                        <div class="form-group">
                            <label id="namaLawanTransaksiLabel" class="col-sm-4 control-label">Nama Lawan Transaksi</label>
                            <div class="col-sm-8">
                                <input type="text" id="namaLwnTransaksi" name="namaLwnTransaksi" maxlength="50"/>    
                            </div>
                        </div> 
                        <!--- NO 8 --->
                        <div class="form-group">
                            <label id="nomorDokumenlabel" class="col-sm-4 control-label">Nomor Dokumen</label>
                            <div class="col-sm-8">
                                <input type="text" id="nomorDokumen" name="nomorDokumen" maxlength="50"/>    
                            </div>
                        </div> 
                        <!--- NO 9 --->
                        <div class="form-group">
                            <label id="jenisDokumenLabel" class="col-sm-4 control-label">Jenis Dokumen</label>
                            <div class="col-sm-8">
                                <select id='jenisDokumen' name="jenisDokumen">
                                    <option value="0">Faktur Pajak</option>
                                    <option value="1">Dokumen yang Dipersamakan Dengan Faktur Pajak</option>
                                </select>   
                            </div>
                        </div> 
                        <!--- NO 10 --->
                        <div class="form-group">
                            <label id="nomorSeriDigantiLabel" class="col-sm-4 control-label">No Seri Faktur Yang Diganti/Diretur</label>
                            <div class="col-sm-8">
                                <input type="text" id="nomorSeriDiganti" name="nomorSeriDiganti" maxlength="50"/>    
                            </div>
                        </div>
                        <!--- NO 11 --->
                        <div class="form-group">
                            <label id="jenisDokumenDigantiLabel" class="col-sm-4 control-label">Jenis Dokumen</label>
                            <div class="col-sm-8">
                                <select id='jenisDokumenDiganti'>
                                    <option value="0">Dokumen Diganti/Diretur adalah Faktur Pajak</option>
                                    <option value="1">Dokumen Diganti/Diretur Dipersamakan Dengan Faktur Pajak</option>
                                </select>   
                            </div>
                        </div>
                        <!--- NO 12 --->
                        <div class="form-group">
                            <label id="tanggalDokumenLabel" class="col-sm-4 control-label">Tanggal Dokumen</label>
                            <div class="col-sm-8">
                                <input type="text" id="tanggalDokumen" name="tanggalDokumen" maxlength="10"/>
                            </div>
                        </div>
                        <!--- NO 13 --->
                        <div class="form-group">
                            <label id="tanggalSSPLabel" class="col-sm-4 control-label">Tanggal SSP</label>
                            <div class="col-sm-8">
                                <input type="text" id="tanggalSSP" name="tanggalSSP" maxlength="10"/>
                            </div>
                        </div>
                        <!--- NO 14 --->
                        <div class="form-group">
                            <label id="masaPajakLabel" class="col-sm-4 control-label">Masa Pajak</label>
                            <div class="col-sm-8">
                                <input type="text" id="masaPajak" name="masaPajak" maxlength="4"/>
                            </div>
                        </div>
                        <!--- NO 15 --->
                        <div class="form-group">
                            <label id="tahunPajakLabel" class="col-sm-4 control-label">Tahun Pajak</label>
                            <div class="col-sm-8">
                                <input type="text" id="tahunPajak" name="tahunPajak" maxlength="4"/>
                            </div>
                        </div>
                        <!--- NO 16 --->
                        <div class="form-group">
                            <label id="pembetulanLabel" class="col-sm-4 control-label">Pembetulan</label>
                            <div class="col-sm-8">
                                <input type="text" id="pembetulan" name="pembetulan" maxlength="2"/>
                            </div>
                        </div>
                        <!--- NO 17 --->
                        <div class="form-group">
                            <label id="DPPLabel" class="col-sm-4 control-label">DPP</label>
                            <div class="col-sm-8">
                                <input type="text" id="DPP" name="DPP"/>
                            </div>
                        </div>
                        <!--- NO 18 --->
                        <div class="form-group">
                            <label id="PPNLabel" class="col-sm-4 control-label">PPN</label>
                            <div class="col-sm-8">
                                <input type="text" id="PPN" name="PPN"/>
                            </div>
                        </div>
                        <!--- NO 19 --->
                        <div class="form-group">
                            <label id="PPnBMLabel" class="col-sm-4 control-label">PPnBM</label>
                            <div class="col-sm-8">
                                <input type="text" id="PPnBM" name="PPnBM" />
                            </div>
                        </div>
                         
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="submit" type="button" class="btn btn-default">Submit</button>
                    <button type="button" class="btn btn-default closeFormModal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>