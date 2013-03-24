package Text::Md2Inao::NodeFactory;
use strict;
use warnings;

use Errno ();
use Module::Load;

use Text::Md2Inao::Node::Text;
use Text::Md2Inao::Node::Unknown;
use Text::Md2Inao::Node::Heading;

sub factory {
    my ($class, $p, $h) = @_;
    if (not ref $h) {
        return Text::Md2Inao::Node::Text->new({ context => $p, element => $h });
    }

    if ($h->tag =~ /^h\d+$/) {
        return Text::Md2Inao::Node::Heading->new({ context => $p, element => $h });
    }

    ## FIXME: 毎回 load してるのは非効率かも。クラスローダーを変える?
    my $pkg = sprintf "Text::Md2Inao::Node::%s", ucfirst $h->tag;
    eval {
        load $pkg;
    };
    if ($@) {
        if ($! ==  Errno::ENOENT) {
            return Text::Md2Inao::Node::Unknown->new({ context => $p, element => $h });
        }
    } else {
        return $pkg->new({ context => $p, element => $h });
    }
}

1;
