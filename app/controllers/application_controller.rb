class ApplicationController < ActionController::Base
  helper_method :parse_text, :auto_report, :weight
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  private 

  def parse_text 
    @description = Description.find(params[:id])
    if ! @description.internal.nil?
     if @description.internal.block_code_composite.nil? or @description.internal.block_code_composite == ""
       return ""
     else
       abc = @description.internal.block_code_composite.split("~~~~~")
       master_array = []
       abc.each do |i|
         master_array.push(i.split("_____"))
       end
       puts "returning everything"
       return master_array
     end
    else
      return ""
    end
  end

  def weight 
    data = { 
      12 => {"gw" => 12	, "fla" => 9	, "fls" => 3,	"crla" => 7.4	,"crls" => 1.1	,"chla" => 9.8	,"chls" => 1.7	,"hca" => 7.1	,"hcs" => 1.1	,"bwa" => 29.6	,"bws" => 14.9},
      13 => {"gw" => 13	, "fla" => 12	, "fls" => 3,	"crla" => 8.7	,"crls" => 1.2	,"chla" => 11.8	,"chls" => 1.8	,"hca" => 8.5	,"hcs" => 1.2	,"bwa" => 37.4	,"bws" => 14.9},
      14 => {"gw" => 14	, "fla" => 15	, "fls" => 3,	"crla" => 9.9	,"crls" => 1.2	,"chla" => 13.7	,"chls" => 1.8	,"hca" => 9.8	,"hcs" => 1.2	,"bwa" => 53	,"bws" => 14.9},
      15 => {"gw" => 15	, "fla" => 18	, "fls" => 3,	"crla" => 11.1	,"crls" => 1.2	,"chla" => 15.6	,"chls" => 1.8	,"hca" => 11.1	,"hcs" => 1.2	,"bwa" => 76.5	,"bws" => 18.5},
      16 => {"gw" => 16	, "fla" => 21	, "fls" => 3,	"crla" => 12.4	,"crls" => 1.3	,"chla" => 17.5	,"chls" => 1.8	,"hca" => 12.4	,"hcs" => 1.3	,"bwa" => 108	,"bws" => 41},
      17 => {"gw" => 17	, "fla" => 24	, "fls" => 3,	"crla" => 13.5	,"crls" => 1.3	,"chla" => 19.3	,"chls" => 1.9	,"hca" => 13.6	,"hcs" => 1.3	,"bwa" => 147	,"bws" => 53},
      18 => {"gw" => 18	, "fla" => 27	, "fls" => 3,	"crla" => 14.7	,"crls" => 1.3	,"chla" => 21.1	,"chls" => 1.9	,"hca" => 14.8	,"hcs" => 1.3	,"bwa" => 194	,"bws" => 65},
      19 => {"gw" => 19	, "fla" => 30	, "fls" => 3,	"crla" => 15.9	,"crls" => 1.3	,"chla" => 22.9	,"chls" => 1.9	,"hca" => 16.0	,"hcs" => 1.3	,"bwa" => 249	,"bws" => 78},
      20 => {"gw" => 20	, "fla" => 33	, "fls" => 3,	"crla" => 17.0	,"crls" => 1.4	,"chla" => 24.6	,"chls" => 1.9	,"hca" => 17.2	,"hcs" => 1.4	,"bwa" => 312	,"bws" => 92},
      21 => {"gw" => 21	, "fla" => 36	, "fls" => 3,	"crla" => 18.2	,"crls" => 1.4	,"chla" => 26.3	,"chls" => 2.0	,"hca" => 18.3	,"hcs" => 1.4	,"bwa" => 382	,"bws" => 107},
      22 => {"gw" => 22	, "fla" => 39	, "fls" => 3,	"crla" => 19.3	,"crls" => 1.4	,"chla" => 28.0	,"chls" => 2.0	,"hca" => 19.4	,"hcs" => 1.4	,"bwa" => 461	,"bws" => 122},
      23 => {"gw" => 23	, "fla" => 41	, "fls" => 4,	"crla" => 20.4	,"crls" => 1.5	,"chla" => 29.6	,"chls" => 2.0	,"hca" => 20.5	,"hcs" => 1.4	,"bwa" => 547	,"bws" => 122},
      24 => {"gw" => 24	, "fla" => 44	, "fls" => 4,	"crla" => 21.5	,"crls" => 1.5	,"chla" => 31.2	,"chls" => 2.0	,"hca" => 21.6	,"hcs" => 1.5	,"bwa" => 641	,"bws" => 137},
      25 => {"gw" => 25	, "fla" => 47	, "fls" => 4,	"crla" => 22.6	,"crls" => 1.5	,"chla" => 32.8	,"chls" => 2.1	,"hca" => 22.6	,"hcs" => 1.5	,"bwa" => 743	,"bws" => 154},
      26 => {"gw" => 26	, "fla" => 50	, "fls" => 4,	"crla" => 23.6	,"crls" => 1.5	,"chla" => 34.3	,"chls" => 2.1	,"hca" => 23.6	,"hcs" => 1.5	,"bwa" => 853	,"bws" => 171},
      27 => {"gw" => 27	, "fla" => 52	, "fls" => 4,	"crla" => 24.7	,"crls" => 1.6	,"chla" => 35.8	,"chls" => 2.1	,"hca" => 24.5	,"hcs" => 1.5	,"bwa" => 971	,"bws" => 188},
      28 => {"gw" => 28	, "fla" => 55	, "fls" => 4,	"crla" => 25.7	,"crls" => 1.6	,"chla" => 37.3	,"chls" => 2.2	,"hca" => 25.5	,"hcs" => 1.6	,"bwa" => 1096	,"bws" => 206},
      29 => {"gw" => 29	, "fla" => 57	, "fls" => 4,	"crla" => 26.7	,"crls" => 1.6	,"chla" => 38.7	,"chls" => 2.2	,"hca" => 26.4	,"hcs" => 1.6	,"bwa" => 1230	,"bws" => 225},
      30 => {"gw" => 30	, "fla" => 60	, "fls" => 4,	"crla" => 27.7	,"crls" => 1.6	,"chla" => 40.1	,"chls" => 2.2	,"hca" => 27.2	,"hcs" => 1.6	,"bwa" => 1371	,"bws" => 244},
      31 => {"gw" => 31	, "fla" => 62	, "fls" => 4,	"crla" => 28.7	,"crls" => 1.7	,"chla" => 41.4	,"chls" => 2.2	,"hca" => 28.1	,"hcs" => 1.7	,"bwa" => 1520	,"bws" => 264},
      32 => {"gw" => 32	, "fla" => 64	, "fls" => 4,	"crla" => 29.7	,"crls" => 1.7	,"chla" => 42.8	,"chls" => 2.3	,"hca" => 28.9	,"hcs" => 1.7	,"bwa" => 1677	,"bws" => 285},
      33 => {"gw" => 33	, "fla" => 67	, "fls" => 4,	"crla" => 30.6	,"crls" => 1.7	,"chla" => 44.0	,"chls" => 2.3	,"hca" => 29.7	,"hcs" => 1.7	,"bwa" => 1842	,"bws" => 306},
      34 => {"gw" => 34	, "fla" => 69	, "fls" => 4,	"crla" => 31.6	,"crls" => 1.8	,"chla" => 45.3	,"chls" => 2.3	,"hca" => 30.5	,"hcs" => 1.7	,"bwa" => 2015	,"bws" => 328},
      35 => {"gw" => 35	, "fla" => 71	, "fls" => 5,	"crla" => 32.5	,"crls" => 1.8	,"chla" => 46.5	,"chls" => 2.3	,"hca" => 31.2	,"hcs" => 1.8	,"bwa" => 2195	,"bws" => 350},
      36 => {"gw" => 36	, "fla" => 73	, "fls" => 5,	"crla" => 33.4	,"crls" => 1.8	,"chla" => 47.7	,"chls" => 2.4	,"hca" => 31.9	,"hcs" => 1.8	,"bwa" => 2383	,"bws" => 373},
      37 => {"gw" => 37	, "fla" => 76	, "fls" => 5,	"crla" => 34.3	,"crls" => 1.8	,"chla" => 48.9	,"chls" => 2.4	,"hca" => 32.6	,"hcs" => 1.8	,"bwa" => 2580	,"bws" => 397},
      38 => {"gw" => 38	, "fla" => 78	, "fls" => 5,	"crla" => 35.2	,"crls" => 1.9	,"chla" => 50.0	,"chls" => 2.4	,"hca" => 33.2	,"hcs" => 1.8	,"bwa" => 2784	,"bws" => 421},
      39 => {"gw" => 39	, "fla" => 80	, "fls" => 5,	"crla" => 36.1	,"crls" => 1.9	,"chla" => 51.1	,"chls" => 2.4	,"hca" => 33.8	,"hcs" => 1.9	,"bwa" => 2996	,"bws" => 446},
      40 => {"gw" => 40	, "fla" => 82	, "fls" => 5,	"crla" => 37.0	,"crls" => 1.9	,"chla" => 52.1	,"chls" => 2.5	,"hca" => 34.4	,"hcs" => 1.9	,"bwa" => 3215	,"bws" => 471},
      41 => {"gw" => 41	, "fla" => 84	, "fls" => 5,	"crla" => 37.8	,"crls" => 1.9	,"chla" => 53.1	,"chls" => 2.5	,"hca" => 35.0	,"hcs" => 1.9	,"bwa" => 3443	,"bws" => 497},
      42 => {"gw" => 42	, "fla" => 86	, "fls" => 5,	"crla" => 38.6	,"crls" => 2	,"chla" => 54.1	,"chls" => 2.5	,"hca" => 35.5	,"hcs" => 2.0	,"bwa" => 3678	,"bws" => 524},
      43 => {"gw" => 43	, "fla" => 88	, "fls" => 5,	"crla" => 39.4	,"crls" => 2	,"chla" => 55.0	,"chls" => 2.5	,"hca" => 36.0	,"hcs" => 2.0	,"bwa" => 3922	,"bws" => 551},
      200 => {"gw" => nil , "fla" => nil   , "fls" => nil,   "crla" => nil  ,"crls" => nil    ,"chla" => nil ,"chls" => nil  ,"hca" => nil ,"hcs" => nil   ,"bwa" => nil  ,"bws" => nil}
    }
    data[@description.patient.age < 12 ? 12 : @description.patient.age] rescue data[200]
  end

  def auto_report
    final_report = String.new()
    if !@description.patient.nil?
      final_report = "<p>Provisional findings in the autopsy performed on <strong>#{@description.patient.name}</strong> are as follows. A final report will be available following completion of all facets of the case.</p><br>"
    end

    if ! @description.mother_datum.nil? 
      final_report += "<li> <strong>#{@description.patient.age}</strong> weeks old, <strong>#{@description.patient.sex}</strong> stillborn delivered to a <strong>#{@description.mother_datum.mother_age rescue "N/A"}</strong> year old, G<strong>#{@description.mother_datum.gravida rescue "N/A" }</strong> P<strong>#{@description.mother_datum.para rescue "N/A"}</strong> mother via <strong>#{@description.mother_datum.type_of_delivery rescue "N/A"}</strong> delivery; with a history of #{@description.mother_datum.mother_medical_history.html_safe rescue "N/A"}</li><br>"
    end

    if ! @description.external.nil?
      final_report += "<li>
      #{@description.external.degree_of_maceration.capitalize rescue "N/A"} maceration, #{@description.external.development_habitus rescue "N/A" } development <br>
          <br>
          <ol>
	   <li>Birth weight <strong>#{@description.external.birth_weight rescue "N/A" }</strong> gm, (expected for age: <i>#{ weight["bwa"] } ± #{ weight["bws"]}</i> gms)
	   <li>Crown rump length <strong>#{@description.external.crown_rump_length rescue "N/A"}</strong> cm, (expected for age: <i>#{ weight["crla"] } ± #{ weight["crls"]}</i> cm)
	   <li>Crown heel length <strong>#{@description.external.crown_heel_length rescue "N/A" }</strong> cm, (expected for age: <i>#{ weight["chla"] } ± #{ weight["chls"]}</i> cm)
	   <li>Foot length <strong>#{@description.external.foot_length rescue "N/A" }</strong> cm, (expected for age: <i>#{weight["fla"]} ± #{weight["fls"]}</i> cm)
	  </ol>
      </li><br>"
    end

    final_report += "<li>Major provisional diagnosis:<br><br>Replace this text with your findings</li><br>"

    if !@description.placenta.nil?
      final_report += "<li>Placenta:
	   <ol>
	    <li> #{@description.placenta.weight} gm, <…> expected for <…> weeks gestation; fetal placental weight ratio <….>, <…> expected.
	    <li> Umbilical cord, <….> cm long, <…> vessels.
	    <li> Pending detailed examination following fixation.
	   </ol></li><br>
           "
    end

    if !@description.ancillary_testing.nil?
      final_report += "<li>Ancilliary Testing Results<br>
      Replace this text with findings of ancilliary testings.
      "
    end

    return final_report
  end

end
