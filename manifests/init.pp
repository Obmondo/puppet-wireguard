class wireguard (
  Hash[String, Struct[
    {
      ensure      => Optional[String],
      private_key => String,
      listen_port => Integer,
      virtual_ip  => String,
      peers       => Hash,
    }
  ]] $tunnels = {},
  Hash[String, Struct[
    {
      ensure           => Optional[String],
      private_key      => String,
      listen_port      => Integer,
      virtual_ip       => String,
      peer_public_key  => String,
      peer_allowed_ips => Optional[String],
      peer_endpoint    => Optional[String],
    }
  ]] $simple_tunnels = [],
) {
  include wireguard::packages

  $tunnels.each |$name, $params| {
    wireguard::tunnel { $name:
      * => $params,
    }
  }
  $simple_tunnels.each |$name, $params| {
    wireguard::simple_tunnel { $name:
      * => $params,
    }
  }
}
