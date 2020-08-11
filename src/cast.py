import logging
import pychromecast

logger = logging.getLogger(__name__)


class Caster:
    def __init__(self, stream_url):
        self.stream_url = stream_url

        logger.info("Searching for Chromecast devices...")
        # chromecast_list = pychromecast.get_chromecasts_as_dict().keys()
        casts, browser = pychromecast.get_chromecasts()
        pychromecast.discovery.stop_discovery(browser)
        logger.debug("Found Chromecasts: %s", casts)

        if len(casts) == 0:
            raise RuntimeError("Unable to find a Chromecast on the local network.")

        cast = casts[0]
        if len(casts) > 1:
            logger.warn("Multiple Chromecast devices detected, using defaulting to Chromecast '%s'", cast.name)

        logger.info("Connecting to Chromecast '%s'", cast.name)
        self.chromecast = cast
        self.chromecast.wait()
        logger.info("Connected to Chromecast '%s'", cast.name)

    def start_stream(self):
        logger.info("Starting stream of URL %s on Chromecast '%s'",
                    self.stream_url, self.device_name)

        self.chromecast.quit_app()

        mc = self.chromecast.media_controller
        mc.play_media(self.stream_url, 'audio/flac', stream_type="LIVE")

    @property
    def device_name(self):
        return self.chromecast.device.friendly_name
