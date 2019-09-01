$ip = “172.17.1”

1..4 | %{
        if (!(test-connection “$ip`.$_” -count 1 -quiet))
            {
            write-host -f Red “$ip`.$_ host not responding”
            }
        else
            {
            write-host -f Green “$ip`.$_ host up”
            }
        }
