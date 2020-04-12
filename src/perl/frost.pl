#!perl

use LWP::UserAgent;
use JSON;
use Time::Piece;
use POSIX;

my $SMHI_URL = 'https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/17.846746/lat/59.417838/data.json';

my $ua = LWP::UserAgent->new;
my $resp = $ua->get($SMHI_URL);
my $weather_data = decode_json($resp->decoded_content);

my $time_series = $weather_data->{timeSeries};

for my $ts (@$time_series){
    my $params = $ts->{parameters};
    for my $parameter (@$params){
        if($parameter->{name} eq "t" and $parameter->{values}[0] < 1.0){
            my $utc_time = Time::Piece->strptime($ts->{validTime}, "%Y-%m-%dT%H:%M:%SZ");  
            my $local_time = localtime($utc_time->epoch);
            print $local_time->strftime('%Y-%m-%d %H:00');
            print " $parameter->{values}[0] \n";        
        }
    }
}
